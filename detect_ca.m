function [start_tmp_big5, peak_tmp_big5, finish_tmp_big5] = detect_ca(data, fs)
%DETECT_CA �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��

data_len = length(data(1, :));
%% �ҷ�ֵ ��ʼ�� ������

peak_tmp_all = cell(data_len, 1);  % ������ֵ���cell��ÿ����Ԫ1��ROI��cell
filter_high = zeros(data_len, 1);    % ѡ���ֵ
data_base = zeros(data_len, 1);
for k = 1 : data_len
    data_base(k) = prctile(data(:, k), 20);    % ���ߣ�
%     filter_high(k) = 3 * std(data(:, k));
    filter_high(k) = 0.1;

    [~, peak_tmp_k] = findpeaks(data(:, k), 'MinPeakHeight', filter_high(k), 'MinPeakDistance', fs * 5);
    peak_tmp_all{k, 1} = peak_tmp_k;
end

%% ����ʼ��
filter_low_start = zeros(data_len, 1); % ѡ����ʼ����ֵ
start_tmp_all = cell(data_len, 1); % ��ʼ��

for k = 1 : data_len
    peak_len = length(peak_tmp_all{k, 1});
    filter_low_start(k, 1) = 0.06;
    start_tmp_all{k, 1} = zeros(peak_len, 1);
    if peak_len ~= 0
        % ���ÿ����ֵ�����ʼ��ͽ�����, ���ù�ֵ �� ����
        for i = 1 : peak_len
            % ��������ʼ��ͽ�����Ĺ�ֵ
            % ���ֻ��1����ֵ��
            if peak_len == 1
                [~, start_loc_tmp] = find_valley(data(1 : peak_tmp_all{k, 1}(i), k), filter_low_start(k, 1));     
                [start_intersect_tmp] = find_intersection(data(1 : peak_tmp_all{k, 1}(i), k), filter_low_start(k));
            % ����ǵ�1����ֵ��
            elseif i == 1   
                [~, start_loc_tmp] = find_valley(data(1 : peak_tmp_all{k, 1}(i), k), filter_low_start(k, 1));
                
                [start_intersect_tmp] = find_intersection(data(1 : peak_tmp_all{k, 1}(i), k),  filter_low_start(k));
            % ��������1����ֵ��
            elseif i == peak_len
                [~, start_loc_tmp] = find_valley(data(peak_tmp_all{k, 1}(i - 1) : peak_tmp_all{k, 1}(i), k), filter_low_start(k, 1));
                start_loc_tmp = start_loc_tmp + peak_tmp_all{k, 1}(i - 1) - 1;
                
                [start_intersect_tmp] = find_intersection(data(peak_tmp_all{k, 1}(i - 1) : peak_tmp_all{k, 1}(i), k),  filter_low_start(k));
                start_intersect_tmp = start_intersect_tmp + peak_tmp_all{k, 1}(i - 1) - 1;
            else
                [~, start_loc_tmp] = find_valley(data(peak_tmp_all{k, 1}(i - 1) : peak_tmp_all{k, 1}(i), k), filter_low_start(k, 1));
                start_loc_tmp = start_loc_tmp + peak_tmp_all{k, 1}(i - 1) - 1;
                
                [start_intersect_tmp] = find_intersection(data(peak_tmp_all{k, 1}(i - 1) : peak_tmp_all{k, 1}(i), k),  filter_low_start(k));
                start_intersect_tmp = start_intersect_tmp + peak_tmp_all{k, 1}(i - 1) - 1;
            end
            
            % ��� ����ʼ�㣬 ��ѡ���ұߵ�1��
            if ~isempty(start_loc_tmp)
                start_tmp_all{k, 1}(i, 1) = start_loc_tmp(end);
            elseif i == 1   % ���û����ʼ�㲢���ǵ�һ����ֵ��
                start_tmp_all{k, 1}(i, 1) = start_intersect_tmp(end);
            end
        end

    end
end

%% �ҽ�����
finish_tmp_all = cell(data_len, 1);
filter_low_finish = cell(data_len, 1);
for k = 1 : data_len
    peak_len = length(peak_tmp_all{k, 1});
    finish_tmp_all{k, 1} = zeros(peak_len, 1);
    filter_low_finish{k, 1} = zeros(peak_len, 1);
    if peak_len ~= 0      
        % ǰ n - 1��������
        for i = 1 : peak_len - 1
            cnt = i;
            while cnt >= 1 && start_tmp_all{k, 1}(cnt) == 0
                cnt = cnt - 1;
            end
            if start_tmp_all{k, 1}(cnt) ~= 0
                filter_low_finish{k, 1}(i) = max(data(start_tmp_all{k, 1}(cnt), k) + 0.05, 0.06);
                [~, finish_tmp_k] = find_valley(data(peak_tmp_all{k, 1}(cnt) : peak_tmp_all{k, 1}(i + 1), k), filter_low_finish{k, 1}(i));
                finish_tmp_k = finish_tmp_k + peak_tmp_all{k, 1}(cnt) - 1;
            end
            % �ж� �� i + 1 ����ʼ��
            % 1. i + 1 ����ʼ��Ϊ0����û����ʼ��
            % 2. �� cnt �� i��1 �ĸ��źŵķ�ֵ��֮�䣬ֻ��һ����ֵ
            % 3. �� cnt �����źŵ���ʼ�� ���� 
            % 4. �� cnt �����źŵ���ʼ�� ���� ��ʼ����ֵҪ�󣬼�����ͨ���˷����õ���
            if start_tmp_all{k, 1}(i + 1) == 0 && length(finish_tmp_k) == 1 && start_tmp_all{k, 1}(cnt) ~= 0 && data(start_tmp_all{k, 1}(cnt), k) <= filter_low_start(k, 1)
                start_tmp_all{k, 1}(i + 1) = finish_tmp_k(end);
            end
            % ��ȡ������
            if ~isempty(finish_tmp_k)
                finish_tmp_all{k, 1}(i) = finish_tmp_k(1);
            end
        end
        % ������1�����ź�
        cnt = peak_len;
        while cnt >= 1 && start_tmp_all{k, 1}(cnt) == 0
            cnt = cnt - 1;
        end
        if start_tmp_all{k, 1}(cnt) ~= 0
            filter_low_finish{k, 1}(peak_len) = data(start_tmp_all{k, 1}(cnt), k) + 0.05;
            [~, finish_tmp_k] = find_valley(data(peak_tmp_all{k, 1}(cnt) : end, k), filter_low_finish{k, 1}(peak_len));
            finish_tmp_k = finish_tmp_k + peak_tmp_all{k, 1}(cnt) - 1;
        end
        if ~isempty(finish_tmp_k)
            finish_tmp_all{k, 1}(peak_len) = finish_tmp_k(1);
        end
    end
end

%% ɸѡ
peak_tmp = peak_tmp_all;
start_tmp = start_tmp_all;
finish_tmp = finish_tmp_all;
start_tmp_merge = cell(data_len, 1);
peak_tmp_merge = cell(data_len, 1);
finish_tmp_merge = cell(data_len, 1);
for k = 1 : data_len
    peak_all_len = length(peak_tmp_all{k, 1});
    if peak_all_len ~= 0
        for i = 2 : peak_all_len
            % ���startΪ0�� ֤����ǰһ���ź���ͬһ���ź�
            % ����ǰ��start ��ǰһ���źŵ�finish ��0
            % ���������ź��н�С����0
            if start_tmp{k, 1}(i) == 0
                finish_tmp{k, 1}(i - 1) = 0;
                if data(peak_tmp{k, 1}(i - 1), k) > data(peak_tmp{k, 1}(i), k)
                    peak_tmp{k, 1}(i) = peak_tmp{k, 1}(i - 1);
                end
                peak_tmp{k, 1}(i - 1) = 0;
            end
        end
        % ��1�����ź� û����ʼ�㡪��ȥ�����������û����ʼ���ý���
        % ���1�����ź�û�н�����
        if finish_tmp{k, 1}(peak_all_len) == 0
            peak_tmp{k, 1}(peak_all_len) = 0;
            cnt = peak_all_len;
            while start_tmp{k, 1}(cnt) == 0
                cnt = cnt - 1;
            end
            start_tmp{k, 1}(cnt) = 0;
        end
    end
    
    not_ca_len = length(find(peak_tmp{k, 1} == 0));
    peak_tmp_merge{k, 1} = sort(peak_tmp{k, 1});
    peak_tmp_merge{k, 1} = peak_tmp_merge{k, 1}(not_ca_len + 1: end);
    start_tmp_merge{k, 1} = sort(start_tmp{k, 1});
    start_tmp_merge{k, 1} = start_tmp_merge{k, 1}(not_ca_len + 1: end);
    finish_tmp_merge{k, 1} = sort(finish_tmp{k, 1});
    finish_tmp_merge{k, 1} = finish_tmp_merge{k, 1}(not_ca_len + 1: end);
end

%% ͳ��
total_number_merge = zeros(data_len, 1);
duration_merge = cell(data_len, 1);
amplitude_merge = cell(data_len, 1);
for k = 1 : data_len
    total_number_merge(k, 1) = length(peak_tmp_merge{k, 1});
    tmp1 = start_tmp_merge{k, 1};
    tmp2 = peak_tmp_merge{k, 1};
    tmp3 = finish_tmp_merge{k, 1};
    
    for i = 1 : length(tmp1)
        duration_merge{k, 1}(i) = (tmp3(i) - tmp1(i) + 1) / fs;
        amplitude_merge{k, 1}(i) = data(tmp2(i), k) - data(tmp1(i), k);
    end
end

%% ����С��0.5����0
peak_tmp_big5 = peak_tmp_merge;
start_tmp_big5 = start_tmp_merge;
finish_tmp_big5 = finish_tmp_merge;
for k = 1 : data_len
    amplitude_merge_len = length(amplitude_merge{k, 1});
    for i = 1 : amplitude_merge_len
        if amplitude_merge{k, 1}(i) < 0.5
            peak_tmp_big5{k, 1}(i) = 0;
            start_tmp_big5{k, 1}(i) = 0;
            finish_tmp_big5{k, 1}(i) = 0;
        end
    end
end

%% ɸѡ
for k = 1 : data_len
    if ~isempty(peak_tmp_big5{k, 1})
        not_ca_len = length(find(peak_tmp_big5{k, 1} == 0));

        peak_tmp_big5{k, 1} = sort(peak_tmp_big5{k, 1});
        peak_tmp_big5{k, 1} = peak_tmp_big5{k, 1}(not_ca_len + 1: end);
        start_tmp_big5{k, 1} = sort(start_tmp_big5{k, 1});
        start_tmp_big5{k, 1} = start_tmp_big5{k, 1}(not_ca_len + 1: end);
        finish_tmp_big5{k, 1} = sort(finish_tmp_big5{k, 1});
        finish_tmp_big5{k, 1} = finish_tmp_big5{k, 1}(not_ca_len + 1: end);
    end
end

end

