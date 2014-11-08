function routine=FillPath(source,dest,bufsize)
    flag_col=1;
    flag_row=1;
    
    routine=[];
    next_router=source;
    
    col_dest=dest.Col;
    row_dest=dest.Row;
   
    sc=struct('SCL',rtcpjdl(1,0,0),'SCU',rtcpjdu(1,0,0));
    
    while flag_col
        col_source=next_router.Col;
        if col_source < col_dest
            routine=[routine,struct('router',next_router,'port',2,'ServiceCurve',sc,'BufSize',bufsize)];
            next_router.Col=next_router.Col+1;
        elseif col_source > col_dest
            routine=[routine,struct('router',next_router,'port',1,'ServiceCurve',sc,'BufSize',bufsize)];
            next_router.Col=next_router.Col-1;
        elseif col_source == col_dest
            flag_col=0;
            row_source=next_router.Row;
            if row_source < row_dest
                routine=[routine,struct('router',next_router,'port',4,'ServiceCurve',sc,'BufSize',bufsize)];
                next_router.Row=next_router.Row+1;
            elseif row_source > row_dest
                routine=[routine,struct('router',next_router,'port',3,'ServiceCurve',sc,'BufSize',bufsize)];
                next_router.Row=next_router.Row-1;
            else
                flag_row=0;
                routine=[routine,struct('router',dest,'port',5,'ServiceCurve',sc,'BufSize',bufsize)];
            end
        end
    end
    
     while flag_row
            row_source=next_router.Row;
        if row_source < row_dest
            routine=[routine,struct('router',next_router,'port',4,'ServiceCurve',sc,'BufSize',bufsize)];
            next_router.Row=next_router.Row+1;
        elseif col_source > col_dest
            routine=[routine,struct('router',next_router,'port',3,'ServiceCurve',sc,'BufSize',bufsize)];
            next_router.Row=next_router.Row-1;
        elseif col_source == col_dest
            flag_row=0;
            routine=[routine,struct('router',dest,'port',5,'ServiceCurve',sc,'BufSize',bufsize)];
        end
     end
end