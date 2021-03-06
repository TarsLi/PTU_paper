% All
% Compila los metadatos de los plásmidos de cada grafo

plasmid_info = readtable('../plasmid_mob_pfinder_pGroup_filt.tsv','FileType','text','TextType','string','Format','%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s');

plasmid_list=cellstr(node.AccessionVersion(:,:));

% Coge todos los ficheros de grafos
lst = dir('0_*');
nFiles = length(lst);

fileID = fopen('plsm_subgraph_assignment.tsv' ,'w');
fprintf(fileID, 'AccessionVersion\tSubGraph\tSubGraphSize\tMOB_60\tSize\tTaxPhylum\tTaxClass\tTaxOrder\tTaxFamily\tTaxGenus\tTaxSpecies\n');
for k=1:nFiles
    H = leegrafo(lst(k).name);
    for n = 1:height(H.Nodes)
        fprintf(fileID, '%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n', ...
                string(H.Nodes.AccessionVersion(n)), ...
                lst(k).name, ...
                string(height(H.Nodes)), ...
                plasmid_info.MOB_60((strcmp(plasmid_info.AccessionVersion,H.Nodes.AccessionVersion(n))),1), ...
                plasmid_info.Size((strcmp(plasmid_info.AccessionVersion,H.Nodes.AccessionVersion(n))),1), ...
                plasmid_info.TaxPhylum((strcmp(plasmid_info.AccessionVersion,H.Nodes.AccessionVersion(n))),1), ...
                plasmid_info.TaxClass((strcmp(plasmid_info.AccessionVersion,H.Nodes.AccessionVersion(n))),1), ...
                plasmid_info.TaxOrder((strcmp(plasmid_info.AccessionVersion,H.Nodes.AccessionVersion(n))),1), ...
                plasmid_info.TaxFamily((strcmp(plasmid_info.AccessionVersion,H.Nodes.AccessionVersion(n))),1), ...
                plasmid_info.TaxGenus((strcmp(plasmid_info.AccessionVersion,H.Nodes.AccessionVersion(n))),1), ...
                plasmid_info.TaxSpecies((strcmp(plasmid_info.AccessionVersion,H.Nodes.AccessionVersion(n))),1));
        plasmid_list(strcmp(plasmid_list, H.Nodes.AccessionVersion(n)))=[];
    end
end
for k=1:length(plasmid_list)
    fprintf(fileID, '%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n', ...
            string(plasmid_list(k)), ...
            '-', ...
            '0', ...
            plasmid_info.MOB_60((strcmp(plasmid_info.AccessionVersion,plasmid_list(k))),1), ...
            plasmid_info.Size((strcmp(plasmid_info.AccessionVersion,plasmid_list(k))),1), ...
            plasmid_info.TaxPhylum((strcmp(plasmid_info.AccessionVersion,plasmid_list(k))),1), ...
            plasmid_info.TaxClass((strcmp(plasmid_info.AccessionVersion,plasmid_list(k))),1), ...
            plasmid_info.TaxOrder((strcmp(plasmid_info.AccessionVersion,plasmid_list(k))),1), ...
            plasmid_info.TaxFamily((strcmp(plasmid_info.AccessionVersion,plasmid_list(k))),1), ...
            plasmid_info.TaxGenus((strcmp(plasmid_info.AccessionVersion,plasmid_list(k))),1), ...
            plasmid_info.TaxSpecies((strcmp(plasmid_info.AccessionVersion,plasmid_list(k))),1));
end
fclose(fileID);
