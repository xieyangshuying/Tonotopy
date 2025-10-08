function [duration] = get_duration(start, finish, fs)
    len = length(start);
    duration = cell(len, 1);
    for k = 1 : len
        duration{k, 1} = (finish{k, 1} - start{k, 1}) / fs;
    end
end

