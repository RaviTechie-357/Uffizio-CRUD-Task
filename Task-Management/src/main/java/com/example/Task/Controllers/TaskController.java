package com.example.Task.Controllers;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.example.Task.Model.Task;
import com.example.Task.Service.TaskDao;

@RestController
@RequestMapping("/Task")
public class TaskController {
	

	
	@Autowired
	TaskDao td;
	
	@PostMapping("/SaveTask")
	public ResponseEntity<Task> get(@RequestBody Task tk)
	{		
	Task th=td.SaveTaskData(tk);		
	return ResponseEntity.ok(th);
	}
	
	@GetMapping("/getAll")
	public ResponseEntity<List<Task>> getAllTasks() {
	     List<Task> tasks = td.getAllTasks();
	     return ResponseEntity.ok(tasks);
   }
	@GetMapping("/get/{id}")
	public ResponseEntity<Task> getTaskById(@PathVariable Long id) {
	      Optional<Task> task = td.getTaskById(id);
	      return task.map(ResponseEntity::ok)
	                  .orElse(ResponseEntity.notFound().build());
   }
	
	 @PutMapping("/update/{id}")
	 public ResponseEntity<Task> updateTask(@PathVariable Long id, @RequestBody Task updatedTask) {
	        Optional<Task> task = td.getTaskById(id);
	        if (task.isPresent()) {
	            updatedTask.setId(id);
	            Task savedTask = td.SaveTaskData(updatedTask);
	            return ResponseEntity.ok(savedTask);
	        } 
	        else {
	            return ResponseEntity.notFound().build();
	        }
	    }
	 @DeleteMapping("/delete/{id}")
	 public String deleteTask(@PathVariable Long id) {
	     td.deleteTaskById(id);
	     return "Task with ID " + id + " has been deleted successfully.";
	 }
	 
	 @PatchMapping("/markComplete/{id}")
	 public ResponseEntity<Void> markTaskAsComplete(@PathVariable Long id) {
	     try {
	         td.markTaskAsComplete(id); // Call service to mark task as complete
	         return ResponseEntity.ok().build();
	     } catch (RuntimeException e) {
	         return ResponseEntity.notFound().build(); // Task not found
	     }
	 }


}
