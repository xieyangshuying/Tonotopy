function [start_tmp_big5, peak_tmp_big5, finish_tmp_big5] = detect_ca(data, fs)
%DETECT_CA 此处显示有关此函数的摘要
%   此处显示详细说明

data_len = length(data(1, :));
%% 找峰值 起始点 结束点

peak_tmp_all = cell(data_len, 1);  % 创建峰值点的cell，每个单元1个ROI的cell
filter_high = zeros(data_len, 1);    % 选择峰值
data_base = zeros(data_len, 1);
for k = 1 : data_len
    data_base(k) = prctile(data(:, k), 20);    % 基线？
%     filter_high(k) = 3 * std(data(:, k));
    filter_high(k) = 0.1;

    [~, peak_tmp_k] = findpeaks(data(:, k), 'MinPeakHeight', filter_high(k), 'MinPeakDistance', fs * 5);
    peak_tmp_all{k, 1} = peak_tmp_k;
end

%% 找起始点
filter_low_start = zeros(data_len, 1); % 选择起始点阈值
start_tmp_all = cell(data_len, 1); % 起始点

for k = 1 : data_len
    peak_len = length(peak_tmp_all{k, 1});
    filter_low_start(k, 1) = 0.06;
    start_tmp_all{k, 1} = zeros(peak_len, 1);
    if peak_len ~= 0
        % 检测每个峰值点的起始点和结束点, 利用谷值 和 交点
        for i = 1 : peak_len
            % 可能是起始点和结束点的谷值
            % 如果只有1个峰值点
            if peak_len == 1
                [~, start_loc_tmp] = find_valley(data(1 : peak_tmp_all{k, 1}(i), k), filter_low_start(k, 1));     
                [start_intersect_tmp] = find_intersection(data(1 : peak_tmp_all{k, 1}(i), k), filter_low_start(k));
            % 如果是第1个峰值点
            elseif i == 1   
                [~, start_loc_tmp] = find_valley(data(1 : peak_tmp_all{k, 1}(i), k), filter_low_start(k, 1));
                
                [start_intersect_tmp] = find_intersection(data(1 : peak_tmp_all{k, 1}(i), k),  filter_low_start(k));
            % 如果是最后1个峰值点
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
            
            % 如果 有起始点， 就选择右边第1个
            if ~isempty(start_loc_tmp)
                start_tmp_all{k, 1}(i, 1) = start_loc_tmp(end);
            elseif i == 1   % 如果没有起始点并且是第一个峰值点
                start_tmp_all{k, 1}(i, 1) = start_intersect_tmp(end);
            end
        end

    end
end

%% 找结束点
finish_tmp_all = cell(data_len, 1);
filter_low_finish = cell(data_len, 1);
for k = 1 : data_len
    peak_len = length(peak_tmp_all{k, 1});
    finish_tmp_all{k, 1} = zeros(peak_len, 1);
    filter_low_finish{k, 1} = zeros(peak_len, 1);
    if peak_len ~= 0      
        % 前 n - 1个结束点
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
            % 判断 第 i + 1 个起始点
            % 1. i + 1 的起始点为0——没有起始点
            % 2. 第 cnt 和 i＋1 的钙信号的峰值点之间，只有一个谷值
            % 3. 第 cnt 个钙信号的起始点 存在 
            % 4. 第 cnt 个钙信号的起始点 满足 起始点阈值要求，即不是通过此方法得到的
            if start_tmp_all{k, 1}(i + 1) == 0 && length(finish_tmp_k) == 1 && start_tmp_all{k, 1}(cnt) ~= 0 && data(start_tmp_all{k, 1}(cnt), k) <= filter_low_start(k, 1)
                start_tmp_all{k, 1}(i + 1) = finish_tmp_k(end);
            end
            % 获取结束点
            if ~isempty(finish_tmp_k)
                finish_tmp_all{k, 1}(i) = finish_tmp_k(1);
            end
        end
        % 检测最后1个钙信号
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

%% 筛选
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
            % 如果start为0， 证明和前一个信号事同一个信号
            % 将当前的start 和前一个信号的finish 置0
            % 将两个钙信号中较小的置0
            if start_tmp{k, 1}(i) == 0
                finish_tmp{k, 1}(i - 1) = 0;
                if data(peak_tmp{k, 1}(i - 1), k) > data(peak_tmp{k, 1}(i), k)
                    peak_tmp{k, 1}(i) = peak_tmp{k, 1}(i - 1);
                end
                peak_tmp{k, 1}(i - 1) = 0;
            end
        end
        % 第1个钙信号 没有起始点——去掉此种情况，没有起始点用交点
        % 最后1个钙信号没有结束点
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

%% 统计
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

%% 幅度小于0.5的置0
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

%% 筛选
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

