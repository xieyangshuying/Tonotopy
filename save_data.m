function [T1,T2] = save_data(data,fs,day, focus, figure_path)
% 用来生成需要的表格

[start, peak, finish] = detect_ca(data, fs);
data_len = length(data(1, :));

%% 保存图片
save_figure(data, start, peak, finish, figure_path)

%% 统计1 峰值
amplitude = get_amplitude(data, start, peak);

%% 统计2 持续时间
duration = get_duration(start, finish, fs);

%% 同步性
% % 需统计的trace
% % cnt = 2
% 
% if flag == 1
%     times = input([fileNames_3,data_path,'需要进行同步性分析的次数为：']);
%     trace_all = {};
%     trace_number = [];
%     ca_number=zeros(times, times);
%     synch_ca_number_init=zeros(times, times);
%     not_synch_ca_number_init=zeros(times, times);
% 
%     for j = 1:times
%     synch_trace_number = input(['请输入第',num2str(j),'次统计的trace数量:']);
%     trace_number(j) = synch_trace_number;
%     trace = zeros(synch_trace_number, 1);
%     for k = 1 : synch_trace_number
%         c = fprintf('第%d次第%d个trace序号为：',j, k);
%         %trace_all(j,k) = input('');
%         trace(k, 1) = input('');
% 
%     end
%     trace_all = [trace_all;trace'];
%     [ca_number(k,j), synch_ca_number_init(k,j), not_synch_ca_number_init(k,j), is_ca] = get_synch_number(data, start, finish, fs, synch_trace_number, trace + 1);
%     end
% 
%     % ca_number ca信号的总数
%     % synch_ca_number 同步的数量
%     % not_synch_ca_number 非同步的数量
% end


%% 半高宽
[half_width, ~] = get_half_width(data, start, peak, finish, fs);

%% 保存数据
% save_path = file_path + "\" + save_name;

roi = [];   % roi序号
amp = [];   % 幅度
dur = [];   % 持续时间
hw = [];    % 半高宽
roi_num = [];   % roi:0,1,2,3……
mean_amp = [];
mean_dur = [];
mean_hw = [];
for k = 1 : length(peak)
    if isempty(peak{k, 1})
        roi = [roi; k - 1];
        amp = [amp; 0];
        dur = [dur; 0];
        hw = [hw; 0];
        mean_amp = [mean_amp; 0];
        mean_dur = [mean_dur; 0];
        mean_hw = [mean_hw; 0];
    else
        
        tmp1 = zeros(length(peak{k, 1}), 1);
        tmp1(:, 1) = k - 1;
        tmp2 = amplitude{k, 1};  % 幅度
        mean_tmp2 = mean(tmp2);
        tmp3 = duration{k, 1};
        mean_tmp3 = mean(tmp3);
        tmp4 = half_width{k, 1};
        mean_tmp4 = mean(tmp4);
        roi = [roi; tmp1];
        amp = [amp; tmp2];
        dur = [dur; tmp3];
        hw = [hw; tmp4];
        mean_amp = [mean_amp; mean_tmp2];
        mean_dur = [mean_dur; mean_tmp2];
        mean_hw = [mean_hw; mean_tmp2];
    end
end

minutes = repmat([roundn(length(data(:,1))/fs/60,-1)],data_len,1);     % 时间
if length(roi) ~= 0 
    NO_signal = zeros(data_len,1);
    signal = tabulate(roi);       % 统计重复值
    signal_id = signal(:,1)+1;
    signal_value = signal(:,2);
    

    roi_num_temp = 1;    % 计数
    for i = signal_id'
        NO_signal(i) = signal_value(roi_num_temp);
        roi_num_temp = roi_num_temp + 1;
    end

    for i = 0:data_len-1
        roi_num(i+1,1) = i;             % roi编号
    end

    fre_signal = NO_signal./roundn(length(data(:,1))/fs/60,-1);
    roi_len = length(roi);

    % T = table(roi, amp, dur, hw, trace, synch_ca_number, not_synch_ca_number);
    % 第一张表
    day1 = repmat(day,roi_len,1);
    focus1 = repmat(focus,roi_len,1);
    T1 = table(day1, focus1, roi, amp, dur, hw);


    % 第二张表
    day2 = repmat(day,data_len,1);
    focus2 =  repmat(focus,data_len,1);
    
    T2 = table(day2, focus2, roi_num, NO_signal, minutes,fre_signal, mean_amp, mean_dur, mean_hw);
else
    roi = zeros(data_len, 1);
    roi_num = zeros(data_len, 1);
    amp = zeros(data_len, 1);
    dur = zeros(data_len, 1);
    hw = zeros(data_len, 1);
    day2 = repmat(day,data_len,1);
    day1 = day2;
    focus2 =  repmat(focus,data_len,1);
    focus1 = focus2;
    mean_amp = zeros(data_len, 1);
    mean_dur = zeros(data_len, 1);
    mean_hw = zeros(data_len, 1);
    for i = 1 : data_len
        roi(i) = i - 1;
        roi_num(i) = i - 1;
    end
    NO_signal = zeros(data_len, 1);
    fre_signal = zeros(data_len, 1);
    T1 = table(day1, focus1, roi, amp, dur, hw);
    T2 = table(day2, focus2, roi_num, NO_signal, minutes, fre_signal, mean_amp, mean_dur, mean_hw);
end
end

