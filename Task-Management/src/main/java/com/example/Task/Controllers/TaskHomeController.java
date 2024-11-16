package com.example.Task.Controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class TaskHomeController
{
	
	@RequestMapping("/")
	public String one()
	{
		 return "taskindex";
	}

}
