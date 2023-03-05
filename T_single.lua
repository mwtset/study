local function t_single(a,d,z_v_n,z_angle_begin,z_angle_end,z_v_begin,z_v_end,t0)
    --已知量
    z_angle_begin =z_angle_begin or 0--输入关节起始角度值，默认为0
    z_angle_end = z_angle_end or 90--输入关节终止角度值，默认为90
    z_v_begin = z_v_begin or 0 --关节初速度，默认为0
    z_v_end = z_v_end or 0 --关节末速度，默认为0
    a = a--加速阶段加速度，°/s^2
    d = d--减速阶段加速度,°/s^2
    t0 = t0 or 0--移动初始时间，默认0
    s = math.abs(z_angle_begin-z_angle_end) --总路程，单位°
    z_v_n = z_v_n--用户指定的最大速度，°/s

    --未知量
    z_v_n_max = math.sqrt(a*s)--机器人能够达到的最大速度，°/s

    if (z_v_n > z_v_n_max)
    then
        print("用户指定的最大速度超过机器人能达到的最大速度:",z_v_n_max)
    else   
        s1 = z_v_n^2/(2*a) --加速阶段走过的路程
        s3 = z_v_n^2/(2*d) --减速阶段走过的路程
        s2 = s-s1-s3 --匀速阶段走过的路程

        t1 = z_v_n/a + t0 --加速结束（达到最大速度）时间
        t2 = (s2/z_v_n) + t1 --匀速结束（开始减速）时间
        t3 = (z_v_n/d) + t2 --减速结束（达到末速度）时间

        --判断是否存在匀速阶段
        if (s2 > 0)
        then
            print("此时存在匀速阶段")
            s1_now = s1 + z_angle_begin
            t1_now = t1-t0
            s2_now = s2 + s1_now
            t2_now = t2-t1
            s3_now = s3 + s2_now
            t3_now = t3-t2
            print(s1,s2,s3,t1_now,t2_now,t3_now)
            print(s1_now,t1)
            print(s2_now,t2)
            print(s3_now,t3)
        else
            print("此时不存在匀速阶段")    
        end    
    end
    return t3
end

t_single(2,2,10)