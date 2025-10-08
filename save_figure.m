function save_figure(data,start, peak, finish, figure_path)
    figure
    set(0,'DefaultFigureVisible', 'off');   % ≤ªœ‘ æfigure
    data_len = length(data(1, :));
    for k = 1 : data_len
        subplot(data_len, 1, k);
        plot(data(:, k)); hold on;
        scatter(start{k, 1}, data(start{k, 1}, k), 'b*'); hold on;
        scatter(peak{k, 1}, data(peak{k, 1}, k), 'r*'); hold on;
        scatter(finish{k, 1}, data(finish{k, 1}, k), 'g*');
        ylabel(k);
    end

    ss = get(0,'ScreenSize');
    set(gcf, 'Position', ss);
    %     saveas(im, file_path + "\Ca_statistics.tif", "tiffn");
    print(gcf, "-dtiffn", "-r600",figure_path + ".tif")
end

