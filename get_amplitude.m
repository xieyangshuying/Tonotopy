function [amp] = get_amplitude(data, start, peak)
    len = length(peak);
    amp = cell(len, 1);
    for k = 1 : len
        amp{k, 1} = data(peak{k, 1}, k) - data(start{k, 1}, k);
    end
end

