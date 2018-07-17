try
    if ~exist('md_ctp','var') || ~isa(md_ctp,'cCTP')
        md_ctp = cCTP.citic_kim_fut;
    end
    if ~md_ctp.isconnect, md_ctp.login; end
    
    if ~exist('qms_data_fut','var') || ~isa(qms_data_fut,'cQMS')
        qms_data_fut = cQMS;
        qms_data_fut.setdatasource('ctp');
    end
    
    mde_data_fut = cMDEFut;
    mde_data_fut.qms_ = qms_data_fut;
    
catch
    error('ctp not connected!')
end

%% contracts
codes = {'cu1801';'cu1802';...
    'al1801';'al1802';...
    'zn1801';'zn1802';...
    'pb1801';'pb1802';...
    'ni1805';...
    'rb1805';...
    'i1805';...
    'm1805';...
    'SR805';...
    'T1803';'TF1803'};
futs = cell(size(codes,1),1);
for i = 1:size(codes,1);    
    futs{i} = cFutures(codes{i});
    futs{i}.loadinfo([codes{i},'_info.txt']);
    mde_data_fut.registerinstrument(futs{i});
    
end

trading_freq = 5;
mde_data_fut.setcandlefreq(trading_freq);

%%
mde_data_fut.start;
%%
mde_data_fut.stop;
%%
tick = mde_data_fut.getlasttick(futs{14});
display(datestr(tick(1)));

