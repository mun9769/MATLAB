% 현재 활성화된 Simulink 모델의 이름을 가져옵니다.
model = gcs;

% 모델 내의 모든 Goto 블록을 찾습니다.
goto_blocks = find_system(model, 'BlockType', 'Goto');

% 각 Goto 블록의 높이를 변경합니다.
for i = 1:length(goto_blocks)
    pos = get_param(goto_blocks{i}, 'Position');
    % pos는 [left, top, right, bottom] 형태의 벡터입니다.
    % 높이 = bottom - top
    new_height = 20;
    pos(4) = pos(2) + new_height; % 새로운 bottom 위치 계산
    set_param(goto_blocks{i}, 'Position', pos);
end

% 모델 내의 모든 From 블록을 찾습니다.
from_blocks = find_system(model, 'BlockType', 'From');

% 각 From 블록의 높이를 변경합니다.
for i = 1:length(from_blocks)
    pos = get_param(from_blocks{i}, 'Position');
    new_height = 20;
    pos(4) = pos(2) + new_height;
    set_param(from_blocks{i}, 'Position', pos);
end

disp('모든 Goto 및 From 블록의 높이를 20으로 변경했습니다.');