local function t_single(a,d,z_v_n,z_angle_end,z_angle_begin,z_v_begin,z_v_end,t0)
    --��֪��
    z_angle_begin =z_angle_begin or 0--����ؽ���ʼ�Ƕ�ֵ��Ĭ��Ϊ0
    z_angle_end = z_angle_end or 90--����ؽ���ֹ�Ƕ�ֵ��Ĭ��Ϊ90
    z_v_begin = z_v_begin or 0 --�ؽڳ��ٶȣ�Ĭ��Ϊ0
    z_v_end = z_v_end or 0 --�ؽ�ĩ�ٶȣ�Ĭ��Ϊ0
    a = a--���ٽ׶μ��ٶȣ���/s^2
    d = d--���ٽ׶μ��ٶ�,��/s^2
    t0 = t0 or 0--�ƶ���ʼʱ�䣬Ĭ��0
    s = math.abs(z_angle_begin-z_angle_end) --��·�̣���λ��
    z_v_n = z_v_n--�û�ָ��������ٶȣ���/s

    --δ֪��
    z_v_n_max = math.sqrt(a*s)--�������ܹ��ﵽ������ٶȣ���/s

    if (z_v_n > z_v_n_max)
    then
        print("�û�ָ��������ٶȳ����������ܴﵽ������ٶ�:",z_v_n_max)
        tablet = {0,0,0,0,0,0,0}
    else   
        print("�������ܴﵽ������ٶ�:",z_v_n_max)
        s1 = z_v_n^2/(2*a) --���ٽ׶��߹���·��
        s3 = z_v_n^2/(2*d) --���ٽ׶��߹���·��
        s2 = s-s1-s3 --���ٽ׶��߹���·��

        t1 = z_v_n/a + t0 --���ٽ������ﵽ����ٶȣ�ʱ��
        t2 = (s2/z_v_n) + t1 --���ٽ�������ʼ���٣�ʱ��
        t3 = (z_v_n/d) + t2 --���ٽ������ﵽĩ�ٶȣ�ʱ��

        --�ж��Ƿ�������ٽ׶�
        if (s2 > 0)
        then
            print("----------------------")
            print("��ʱ�������ٽ׶�")
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
            print("��ʱ���������ٽ׶�")    
        end  
         
    end
    return tablet 
end

s_j1 = 90
s_j2 = 60

j1 = t_single(2,2,10,s_j1)
j2 = t_single(1,1,5,s_j2)

--�Ƚ�����ʱ�䣬����tmax���½��й滮
if (j1[7]*j2[7] ~=0)
then
    if (j1[7] > j2[7])
    then
        a = s_j2/(j1[7]*j1[2]-j1[2]^2)
        print("j2���¹滮��")
        j2 = t_single(a,a,a*j1[2],s_j2)
        print("��ʱ���ٶ�Ϊ",a) 
    elseif (j1[7] < j2[7])
    then
        a = s_j1/(j2[7]*j2[2]-j2[2]^2)
        print("j1���¹滮��")
        j1 = t_single(a,a,a*j2[2],s_j1)  
        print("��ʱ���ٶ�Ϊ",a)  
    elseif (j1[7] == j2[7])
    then
        print("��ʵ��ͬ��ͬͣ���������¹滮")
    end
else
    a = 1
end
