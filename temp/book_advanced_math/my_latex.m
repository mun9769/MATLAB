% Define a function to plot the LaTeX text
function my_latex(sym)

    latex_x = latex(sym);
    close all; axis off; 
    text(0, 0.5, ['$$' latex_x '$$'], 'interpreter', 'latex');
end