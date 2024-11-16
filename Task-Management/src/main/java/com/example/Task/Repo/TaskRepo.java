package com.example.Task.Repo;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.Task.Model.Task;

@Repository
public interface TaskRepo extends JpaRepository<Task,Long> 
{
     
	
	
}
