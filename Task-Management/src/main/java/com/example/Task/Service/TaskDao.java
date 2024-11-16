package com.example.Task.Service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.Task.Model.Task;
import com.example.Task.Repo.TaskRepo;

@Service
public class TaskDao 
{

	@Autowired
	TaskRepo tr;

	public Task SaveTaskData(Task tk) 
	{
		Task t1=tr.save(tk);
		return  t1;
		
	}

	public List<Task> getAllTasks() {
        return tr.findAll();
	}

	 public Optional<Task> getTaskById(Long id) {
	    return tr.findById(id);
	}

	public void deleteTaskById(Long id) {
	    tr.deleteById(id);	
	}
	
	public void markTaskAsComplete(Long id) {
	    Optional<Task> taskOpt = tr.findById(id);
	    if (taskOpt.isPresent()) {
	        Task task = taskOpt.get();
	        task.setStatus(Task.Status.COMPLETED); // Update status to COMPLETED
	        tr.save(task); // Save the updated task
	    } else {
	        throw new RuntimeException("Task not found with id: " + id);
	    }
	}

}
