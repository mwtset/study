local function t_single(a,d,z_v_n,z_angle_begin,z_angle_end,z_v_begin,z_v_end,t0)
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
    else   
        s1 = z_v_n^2/(2*a) --���ٽ׶��߹���·��
        s3 = z_v_n^2/(2*d) --���ٽ׶��߹���·��
        s2 = s-s1-s3 --���ٽ׶��߹���·��

        t1 = z_v_n/a + t0 --���ٽ������ﵽ����ٶȣ�ʱ��
        t2 = (s2/z_v_n) + t1 --���ٽ�������ʼ���٣�ʱ��
        t3 = (z_v_n/d) + t2 --���ٽ������ﵽĩ�ٶȣ�ʱ��

        --�ж��Ƿ�������ٽ׶�
        if (s2 > 0)
        then
            print("��ʱ�������ٽ׶�")
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
            print("��ʱ���������ٽ׶�")    
        end    
    end
    return t3
end

t_single(2,2,10)