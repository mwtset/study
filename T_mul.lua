local function t_single(a,d,z_v_n,z_angle_end,z_angle_begin,z_v_begin,z_v_end,t0)
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
        tablet = {0,0,0,0,0,0,0}
    else   
        print("机器人能达到的最大速度:",z_v_n_max)
        s1 = z_v_n^2/(2*a) --加速阶段走过的路程
        s3 = z_v_n^2/(2*d) --减速阶段走过的路程
        s2 = s-s1-s3 --匀速阶段走过的路程

        t1 = z_v_n/a + t0 --加速结束（达到最大速度）时间
        t2 = (s2/z_v_n) + t1 --匀速结束（开始减速）时间
        t3 = (z_v_n/d) + t2 --减速结束（达到末速度）时间

        --判断是否存在匀速阶段
        if (s2 > 0)
        then
            print("----------------------")
            print("此时存在匀速阶段")
            s1_now = s1 + z_angle_begin
            t1_now = t1-t0
            s2_now = s2 + s1_now
            t2_now = t2-t1
            s3_now = s3 + s2_now
            t3_now = t3-t2
            tablet = {s1_now,t1_now,s2_now,t2_now,s3_now,t3_now,t3}
            print(s1_now,t1)
            print(s2_now,t2)
            print(s3_now,t3)
            print("----------------------")
        else
            print("此时不存在匀速阶段")    
        end  
         
    end
    return tablet 
end

s_j1 = 90
s_j2 = 60

j1 = t_single(2,2,10,s_j1)
j2 = t_single(1,1,5,s_j2)

--比较两轴时间，根据tmax重新进行规划
if (j1[7]*j2[7] ~=0)
then
    if (j1[7] > j2[7])
    then
        a = s_j2/(j1[7]*j1[2]-j1[2]^2)
        print("j2重新规划后：")
        j2 = t_single(a,a,a*j1[2],s_j2)
        print("此时加速度为",a) 
    elseif (j1[7] < j2[7])
    then
        a = s_j1/(j2[7]*j2[2]-j2[2]^2)
        print("j1重新规划后：")
        j1 = t_single(a,a,a*j2[2],s_j1)  
        print("此时加速度为",a)  
    elseif (j1[7] == j2[7])
    then
        print("已实现同启同停，无需重新规划")
    end
else
    a = 1
end
