class Family
  @@params1 = {}
  @@params2 = {}
  @@params3 = {}
  @@params = {}
  def family
        p "名前を入力"
        name = "s"
       name = gets.chomp.to_s
       name2 = gets.chomp.to_s
       @@params1 = { first:name, last:name2 }
       name = gets.chomp.to_s
       name2 = gets.chomp.to_s
       @@params2 = { first:name, last:name2 }
       name = gets.chomp.to_s
       name2 = gets.chomp.to_s
       @@params3 = { first:name, last:name2 }
       @@params[:father] = @@params1
       @@params[:mother] = @@params2
       @@params[:son] = @@params3
      p @@params[:father]
      p @@params[:mother]
      p @@params[:son]
  end
end

fam = Family.new
fam.family
