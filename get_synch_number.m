function [ca_number, synch_ca_number, not_synch_ca_number, is_ca] = get_synch_number(data, start, finish, fs, synch_trace_number, trace)
% synch_trace_number��ͳ�Ƶ�trace����
% trace��trace�����
    
    %% ��ÿ�����źŵ����з�ֵ��
    trace_data = data(:, trace);
    trace_start = start(trace, 1);
    trace_finish = finish(trace, 1);
    trace_peak = cell(synch_trace_number, 1);   % ����trace�ķ�ֵ��
    for k = 1 : synch_trace_number
        len_ca = length(trace_start{k, 1});
        trace_peak{k, 1} = cell(len_ca, 1); % ÿ��trace�ķ�ֵ��
        % ͳ��ÿ�����ź�֮��ķ�ֵ��λ��
        for i = 1 : len_ca
            [~, tmp] = findpeaks(trace_data(trace_start{k, 1}(i, 1) : trace_finish{k, 1}(i, 1), k), 'MinPeakHeight', 0.05); 
            trace_peak{k, 1}{i, 1} = tmp + trace_start{k, 1}(i, 1) - 1;
        end
    end
    
    %% ͳ��ͬ����
    ca_number = 0;  % �¼���������
    synch_ca_number = 0;    % ͳ��ͬ��������
    filter_time = 3 * fs;   % �ڸ�ʱ������ͬ�����ź�
    is_ca = cell(synch_trace_number, 1);     % �жϸ��ź��Ƿ��Ѿ��Ǹ��ź�
    for k = 1 : synch_trace_number
        is_ca{k, 1} = zeros(length(trace_start{k, 1}), 1);
    end
    
    for k = 1 : synch_trace_number
        judge_len = length(trace_peak{k, 1});
        ca_number = ca_number + judge_len;
        for i = 1 : judge_len
            judge_peak = trace_peak{k, 1}{i, 1};    % ��Ҫ�жϵĸ��ź�
            for j = k + 1 : synch_trace_number  % ���жϵĸ��ź�
                passive_judge_len = length(trace_peak{j, 1});
                for m = 1 : passive_judge_len
                    passive_peak = trace_peak{j, 1}{m, 1};
                    diff_time = abs(passive_peak' - judge_peak);
                    if ~isempty(find(diff_time < filter_time, 1)) && is_ca{j, 1}(m, 1) == 0
                        synch_ca_number = synch_ca_number + 1;  % ���ڱ��жϵ��ź����� + 1
                        is_ca{j, 1}(m, 1) = 1;
                        if is_ca{k, 1}(i, 1) == 0
                            synch_ca_number = synch_ca_number + 1;  % �����жϵ����� + 1
                            is_ca{k, 1}(i, 1) = 1;
                        end
                    end
                end
            end
        end
    end
    not_synch_ca_number = ca_number - synch_ca_number;
end

