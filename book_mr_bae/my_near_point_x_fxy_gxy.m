function [x,y] = my_near_point_x_fxy_gxy(fxy, gxy)
% f = nx2
% g = mx2

distances = pdist2(fxy, gxy);

% distances 행렬에서 최소 거리와 그 인덱스 찾기
[min_dist, min_idx] = min(distances(:)); % 전체 행렬에서 최소값과 선형 인덱스 찾기

% 선형 인덱스를 행과 열 인덱스로 변환
[row_idx, col_idx] = ind2sub(size(distances), min_idx);

% 가장 가까운 두 점의 좌표 출력
closest_point_fxy = fxy(row_idx, :);
closest_point_gxy = gxy(col_idx, :);

x = closest_point_fxy(1);
y = closest_point_fxy(2);

end
