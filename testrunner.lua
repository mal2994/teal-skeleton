-- all-in-one drop-in test framework:
test = function (title,f)
	local desc=function(msg,f)
		print('✽:desc:'..msg)
		f()
	end
	local it=function(msg,f)
		print('✽:it:'..msg)
		local xs=f and {f()} or {}
		if #xs>0 then
			for i=1,#xs do
				if xs[i]==true then
					print('✽:assert:true')
				else
					print('✽:assert:false')
				end
			end
		else
			print('✽:pend:pend')
		end
		print('✽:it_end')
	end
	print('✽:test:'..title)
	f(desc,it)
	print('✽:test_end')
end

--[[ optional: rerun tests automatically ]]
-- _update = function ()
-- 	if t() >= 02 then
-- 		run()
-- 	end
-- end

package.path = package.path .. ";./lua/?.lua"
require('example.object')
require('example.array')
require('example.tests')

