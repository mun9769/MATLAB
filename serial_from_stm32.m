% 파이썬 코드를 MATLAB으로 변환한 스크립트

% 1. 시리얼 포트 설정
SERIAL_PORT = "COM11"; % COM 포트 이름
BAUD_RATE = 115200;    % 통신 속도

% try-catch 구문을 사용하여 오류 처리
try
    % 2. 시리얼 포트 객체 생성 및 열기
    s = serialport(SERIAL_PORT, BAUD_RATE);
    disp([SERIAL_PORT, ' 포트가 열렸습니다.']);

    % 스크립트 종료 시 (오류 포함) 자동으로 포트를 닫도록 설정
    % Python의 finally 구문과 유사한 역할
    cleanupObj = onCleanup(@() delete(s));

    % 3. 데이터 수신 및 처리 루프 (중지하려면 Ctrl+C)
    while true
        % 버퍼에 16바이트 이상 쌓였는지 확인
        if s.NumBytesAvailable >= 16
            
            % 4. 정확히 16바이트를 읽기 (uint8 형식으로)
            received_bytes = read(s, 16, 'uint8');
            received_bytes = uint8(received_bytes);

            % 5. 16개의 uint8 바이트를 4개의 int32로 변환 (파싱)
            unpacked_data = typecast(received_bytes, 'int32');
            
            % 6. 스케일링을 통해 원래 float 값으로 복원
            vdc    = double(unpacked_data(1)) / 1e3;
            ias    = double(unpacked_data(2)) / 1e3;
            te_est = double(unpacked_data(3)) / 1e6;
            wrpm   = double(unpacked_data(4)) / 1e2;
            wrm = wrpm * (2*pi/60);
            
            % 7. 결과 출력
            fprintf('Vdc: %.2f V, Ias: %.3f A, Te_Est: %.6f Nm, Wrpm: %.0f RPM\n', ...
                    vdc, ias, te_est, wrpm);

            fprintf('eta: %.6f\n', (te_est * wrm) / (vdc * ias) * 100);
            % fprintf('s.NumBytes: %.2f\n', s.NumBytesAvailable);
            flush(s);
        end
        
        % 짧은 대기 (CPU 사용량 줄이기)
        % pause(0.01);
    end
    
catch ME % 오류 발생 시 실행
    disp('오류가 발생했거나 사용자에 의해 중지되었습니다.');

    disp(['오류 메시지: ', ME.message]);
end

% cleanupObj에 의해 시리얼 포트는 자동으로 닫힙니다.
disp('시리얼 포트가 닫혔습니다.');