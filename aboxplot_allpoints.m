% 
% Copyright (C) 2011-2012 Alex Bikfalvi
%
% This program is free software; you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation; either version 3 of the License, or (at
% your option) any later version.

% This program is distributed in the hope that it will be useful, but
% WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
% General Public License for more details.

% You should have received a copy of the GNU General Public License
% along with this program; if not, write to the Free Software
% Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
%

function aboxplot(X,varargin)

% Parameters
widthl = 0.7;
widths = 0.8;
widthe = 0.4;
outMarker = '.';
outMarkerSize = 5 ; % 3;
outMarkerEdgeColor = [0.6 0.6 0.6];
outMarkerFaceColor = [0.6 0.6 0.6];
alpha = 0.05;
cmap = [];
colorrev = 0;
colorgrd = 'blue_down';
alex_LineWidth=2;

% Get the number or data matrices
if iscell(X)
    d = length(X);
else
    % If data is a matrix extend to a 3D array
    if 2 == ndims(X)
        X = reshape(X, [1,size(X)]);
    end
    d = size(X,1);
end;

% Get the data size
if iscell(X)
    n = size(X{1},2);
else
    n = size(X,3);
end

% Set the labels
labels = cell(n,1);
for i=1:n
    labels{i} = num2str(i);
end

% Optional arguments
optargin = size(varargin,2);

i = 1;
while i <= optargin
    switch lower(varargin{i})
        case 'labels'
            labels = varargin{i+1};
        case 'colormap'
            cmap = varargin{i+1};
        case 'colorgrad'
            colorgrd = varargin{i+1};
        case 'colorrev'
            colorrev = varargin{i+1};
        case 'outliermarker'
            outMarker = varargin{i+1};
        case 'outliermarkersize'
            outMarkerSize = varargin{i+1};
        case 'outliermarkeredgecolor'
            outMarkerEdgeColor = varargin{i+1};
        case 'outliermarkerfacecolor'
            outMarkerFaceColor = varargin{i+1};
        case 'widthl'
            widthl = varargin{i+1}
        case 'widths'
            widths = varargin{i+1}
        case 'widthe'
            widthe = varargin{i+1}
    end
    i = i + 2;
end

% Colors
colors = cell(d,n);

if colorrev
    %  Set colormap
    if isempty(cmap)
        cmap = colorgrad(n,colorgrd);
    end
    if size(cmap,1) ~= n
        error('The number of colors in the colormap must equal n.');
    end
    for j=1:d
        for i=1:n
            colors{j,i} = cmap(i,:);
        end
    end
else
    %  Set colormap
    if isempty(cmap)
        cmap = colorgrad(d,colorgrd);
    end
    if size(cmap,1) ~= d
        error('The number of colors in the colormap must equal n.');
    end
    for j=1:d
        for i=1:n
            colors{j,i} = cmap(j,:);
        end
    end
end

xlim([0.5 n+0.5]);

hgg = zeros(d,1);

for j=1:d
    % Get the j matrix
    if iscell(X)
        Y = X{j};
    else
        Y = squeeze(X(j,:,:));
    end
    
    % Create a hggroup for each data set
    hgg(j) = hggroup();
    set(get(get(hgg(j),'Annotation'),'LegendInformation'),'IconDisplayStyle','on');
    legendinfo(hgg(j),'patch',...
        'LineWidth',alex_LineWidth,...%'LineWidth',0.5,...
        'EdgeColor','k',...
        'FaceColor',colors{j,1},...
        'LineStyle','-',...
        'XData',[0 0 1 1 0],...
        'YData',[0 1 1 0 0]);
    
    for i=1:n
    
        % Calculate the mean and confidence intervals
        [q1 q2 q3 fu fl ou ol] = quartile(Y(:,i));
        u = nanmean(Y(:,i));
%         s=nanstd(Y(:,i));
%         n=numel((Y(:,i)));
%         ci_l=u-(1.96/n).*s;
%         ci_h=u+(1.96/n).*s;

        % large interval  [i - widthl/2 i + widthl/2] delta = widthl
        % medium interval start: i - widthl/2 + (j-1) * widthl / d
        % medium interval end: i - widthl/2 + j * widthl / d
        % medium interval width: widthl / d
        % medium interval middle: i-widthl/2+(2*j-1)*widthl/(2*d)
        % small interval width: widths*widthl/d
        % small interval start: i-widthl/2+(2*j-1-widths)*widthl/(2*d)
  
        % Plot outliers
        hold on;
        
        
        
        plot((i-widthl/2+(2*j-1)*widthl/(2*d)).*ones(size(ou)),ou,...
            'LineStyle','none',...
            'Marker',outMarker,...%'Marker','*',...%
            'MarkerSize',outMarkerSize, ...% outMarkerSize,...
            'LineWidth',alex_LineWidth,...
            'MarkerEdgeColor',outMarkerEdgeColor,...
            'MarkerFaceColor',outMarkerFaceColor,...
            'HitTest','off',...
            'Parent',hgg(j));
        plot((i-widthl/2+(2*j-1)*widthl/(2*d)).*ones(size(ol)),ol,...
            'LineStyle','none',...
            'Marker',outMarker,...%'Marker','*',...%
            'LineWidth',alex_LineWidth,...
            'MarkerSize',outMarkerSize, ...% outMarkerSize,...
            'MarkerEdgeColor',outMarkerEdgeColor,...
            'MarkerFaceColor',outMarkerFaceColor,...
            'HitTest','off',...
            'Parent',hgg(j));
        
        
        
       
        
        
        
%        hold off;
        
        % Plot fence
        %inside is q1-1.5*IQR; q2+1.5*IQR (whatever is outside are
        %outliers)
        line([i-widthl/2+(2*j-1)*widthl/(2*d) i-widthl/2+(2*j-1)*widthl/(2*d)],[fu fl],...
            'Color','k','LineStyle',':','LineWidth',alex_LineWidth,'HitTest','off','Parent',hgg(j));
        line([i-widthl/2+(2*j-1-widthe)*widthl/(2*d) i-widthl/2+(2*j-1+widthe)*widthl/(2*d)],[fu fu],...
            'Color','k','LineWidth',alex_LineWidth,'HitTest','off','Parent',hgg(j));
        line([i-widthl/2+(2*j-1-widthe)*widthl/(2*d) i-widthl/2+(2*j-1+widthe)*widthl/(2*d)],[fl fl],...
            'Color','k','LineWidth',alex_LineWidth,'HitTest','off','Parent',hgg(j));
        
        % Plot quantile
        %interquartile range q1 to q3 25%-75% of data range
        if q3 > q1 
            rectangle('Position',[i-widthl/2+(2*j-1-widths)*widthl/(2*d) q1 widths*widthl/d q3-q1],...
                'EdgeColor','k','FaceColor',colors{j,i},'LineWidth',0.5*alex_LineWidth,'HitTest','off','Parent',hgg(j));
        end
        
        % Plot median
        %50% of data range
        line([i-widthl/2+(2*j-1-widths)*widthl/(2*d) i-widthl/2+(2*j-1+widths)*widthl/(2*d)],[q2 q2],...
            'Color','k','LineWidth',alex_LineWidth,'HitTest','off','Parent',hgg(j));
        
        
        
        %plot confidence intervals
        
        %alex plots CI
        
        
% %         s=nanstd(Y(:,i));
% %         nn=sqrt(numel((Y(:,i))))
% %         ci_l=u-(1.96/nn).*s;
% %         ci_h=u+(1.96/nn).*s;
% %         line([i-widthl/2+(2*j-1)*widthl/(2*d) i-widthl/2+(2*j-1)*widthl/(2*d)],[ci_l ci_h],...
% %             'Color','g','LineStyle',':','LineWidth',alex_LineWidth,'HitTest','off','Parent',hgg(j));
% %         line([i-widthl/2+(2*j-1-widthe)*widthl/(2*d) i-widthl/2+(2*j-1+widthe)*widthl/(2*d)],[ci_l ci_l],...
% %             'Color','g','LineWidth',2*alex_LineWidth,'HitTest','off','Parent',hgg(j));
% %         line([i-widthl/2+(2*j-1-widthe)*widthl/(2*d) i-widthl/2+(2*j-1+widthe)*widthl/(2*d)],[ci_h ci_h],...
% %             'Color','g','LineWidth',2*alex_LineWidth,'HitTest','off','Parent',hgg(j));
        
        %end alex plots CI
        
        % Plot mean
        hold on;
        plot(i-widthl/2+(2*j-1)*widthl/(2*d), u,...
            'LineStyle','none',...
            'LineWidth',alex_LineWidth,...
            'Marker','o',...
            'MarkerSize', 2*outMarkerSize, ...
            'MarkerEdgeColor','k',...
            'MarkerFaceColor',colors{j,i},...
            'HitTest','off','Parent',hgg(j));
        
         %alex plots everybody
        plot((i-widthl/2+(2*j-1)*widthl/(2*d)).*ones(size(Y(:,i))),Y(:,i),...
            'LineStyle','none',...
            'Marker','o',...%'Marker',outMarker,...
            'MarkerSize',1.2*outMarkerSize, ...%outMarkerSize,...
            'LineWidth',0.5*alex_LineWidth,...
            'MarkerEdgeColor',[0.3 0.3 0.3], ...% 'g', ...%outMarkerEdgeColor,...
            'MarkerFaceColor',[0.3 0.3 0.3], ... %outMarkerFaceColor,...
            'HitTest','off',...
            'Parent',hgg(j));
        
        %end alex plots everybody
        
        hold off;
    end
end

box on;

set(gca,'XTick',1:n);
set(gca,'XTickLabel',labels, 'LineWidth',0.5*alex_LineWidth, 'FontSize', 14);

end