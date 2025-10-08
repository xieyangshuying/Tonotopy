function [half_width, half_loc] = get_half_width(data,start, peak, finish, fs)
    data_len = length(data(1, :));
    half_width = cell(data_len, 1); % 半高宽
    half_loc = cell(data_len, 1);   % 半高宽的左右位置坐标
    for k = 1 : data_len
        len = length(start{k, 1});
        half_width{k, 1} = zeros(len, 1);
        half_loc{k, 1} = zeros(len, 2);
        for i = 1 : len
            half = data(start{k, 1}(i, 1), k) + (data(peak{k, 1}(i, 1), k) - data(start{k, 1}(i, 1), k)) / 2;
            tmp = find_intersection(data(start{k, 1}(i, 1) : finish{k, 1}(i, 1), k), half);
            tmp = tmp + start{k, 1}(i, 1);
            half_loc{k, 1}(i, 1) = tmp(1);
            half_loc{k, 1}(i, 2) = tmp(end);
            half_width{k, 1}(i, 1) = (tmp(end) - tmp(1)) / fs;
        end
    end
end

