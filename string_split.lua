-- 分割字符串
function split(str,reps)
    local resultStrList = {}
    string.gsub(str,'[^'..reps..']+',function (w)
        table.insert(resultStrList,w)
    end)
    return resultStrList
end

string = '(-10,20,40,90); (10,120,-50,45); (5,60,30,0); (10,20,30,-90)'   --字符串
point = split(string,';')             --输出数组
for i=1,#point do
  print(point[i])
end