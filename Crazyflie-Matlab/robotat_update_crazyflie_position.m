function robotat_update_crazyflie_position(scf, tcp_obj, agents_ids)
    max_retries = 3; 
    for attempt = 1:max_retries
        try
            timeout_count = 0;
            timeout_in100ms = 1 / 0.1;
            read(tcp_obj); 

            if((min(agents_ids) > 0) && (max(agents_ids) <= 100))
                s.dst = 1; 
                s.cmd = 1; 
                s.pld = round(agents_ids);
                write(tcp_obj, uint8(jsonencode(s)));  

                while((tcp_obj.BytesAvailable == 0) && (timeout_count < timeout_in100ms))
                    timeout_count = timeout_count + 1;
                    pause(0.1);
                end

                if(timeout_count == timeout_in100ms)
                    disp('ERROR: Could not receive data from server.');
                    continue;
                else
                    absolute_position = jsondecode(char(read(tcp_obj)));
                    absolute_position = reshape(absolute_position, [7, numel(agents_ids)])';

                    x = absolute_position(1);
                    y = absolute_position(2);
                    z = absolute_position(3);

                    module_name = 'crazyflie_python_commands'; 
                    py_module = py.importlib.import_module(module_name);  
                    py.importlib.reload(py_module);
                
                    try
                        py_module.set_position(scf, x, y, z);
                    catch ME
                        error('Error using crazyflie_python_commands>set_position: %s', ME.message);
                    end  

                    break;
                end
            else
                disp('ERROR: Invalid ID(s).');
                return;
            end
           
        catch ME
            disp(['ERROR: ', ME.message]);
            if attempt == max_retries
                disp('Max retries reached, exiting.');
            else
                disp('Retrying...');
            end
        end
    end
end
