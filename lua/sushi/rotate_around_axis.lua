local deg2rad = math.pi / 180
function sushi.RotateAroundAxis(this, axis, degrees) --Thank you Wiremod!
	local ca, sa = math.cos(degrees*deg2rad), math.sin(degrees*deg2rad)
	local x,y,z = axis[1], axis[2], axis[3]
	local length = (x*x+y*y+z*z)^0.5
	x,y,z = x/length, y/length, z/length
	
	return Vector((ca + (x^2)*(1-ca)) * this[1] + (x*y*(1-ca) - z*sa) * this[2] + (x*z*(1-ca) + y*sa) * this[3],
		(y*x*(1-ca) + z*sa) * this[1] + (ca + (y^2)*(1-ca)) * this[2] + (y*z*(1-ca) - x*sa) * this[3],
	(z*x*(1-ca) - y*sa) * this[1] + (z*y*(1-ca) + x*sa) * this[2] + (ca + (z^2)*(1-ca)) * this[3])
end