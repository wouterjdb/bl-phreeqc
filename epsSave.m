%Save files as eps if save option is on.
if strcmp(P.epsSave,'on')
    filename = input('Specify filename: [no name = not saving]: ', 's');
    filename = strread(filename, '%s', 'delimiter', '.');
   
    if numel(filename) > 0
        print2eps([ P.epsSaveLocation filename{1} '.eps'])
    end           
end


            
            



