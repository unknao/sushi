ENT.PID_Value = {P = 1, I = 0, D = 0}

function ENT:CalculatePID(Error, PID, min, max)
		self.PID_Derivative = self.PID_Derivative and (Error - self.PID_Derivative) * PID.D or 0
		self.PID_Integral = self.PID_Integral and math.Clamp(self.PID_Integral + Error * PID.I, min, max) or 0
		local result = math.Clamp(Error * PID.P + self.PID_Integral + self.PID_Derivative, -min, max)
		
		self.PID_Derivative = Error
		return result
end
	
