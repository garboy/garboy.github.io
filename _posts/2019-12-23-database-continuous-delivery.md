---
layout: post
title:  "数据库持续集成"
date:   2019-12-23 16:38:18 +0800
categories: devops
---

## Basic Principles

**#1 Keep Your Database in a Source Control System**  
including table schema and reference data, e.x States, Countries  
how to distingluish master data and reference data?  
can your application change that data?  
if yes, it's master data.  
else, it's reference data.  

**#2 Incorporate the DB into a CI Process**  
not only apply DDL, DML SQLs, but also run auto tests on each change.  

**#3 Do NOT Use Shared DB among developers**
1. It will allow developer change DB manually, instead of using scripts.
2. It's hard to track db change history.  
3. Hard to deal with merge conflicts.  

**#4 Refactor Your Database Frequently**  
This means when you refactor your domain model, let's say from 'User' to 'Customer', change that table as well.  

## Two Approaches

### 1. State-based approach  

This approaches is introduced by Microsoft?? It maintains a snapshot of database, that means it stores scrips, such as  

```SQL
CREATE TABLE [dbo].[User](...);

CREATE PROCEDURE [dbo].[sp_SelectUsers] AS ...

```

Then a special tools, EF Migration or DB Project will compare target databse and the snapshots, find out the changing part, then generates the upgrage scripts, and execute it to target, by admin manually or by CD agent auto.  

Both table structure and reference data, are need to using scripts to manage, and these script

### 2. Migration-based approach

Miguration-based is write the migration scripts manually, then execute these scripts one by one.  

 Approaches | State of DB | Migration mechanism  
 --- | --- | ---
 Stage-based approach | Explicit | Implicit
 Migration-based approach | Implicit | Explicit  

## Which to choose

### From project side

If your database has lots of logic, such as store procedures, functions, it's better to use state-based approach. Since it'll reduce the merge conflict you need to tediously check by human, line by line.

If you have seldom logic in database, and have multiple database versions in productions, it's better to use migration-based approach, it will be easier to upgrade/downgrade to any version of database.  

Migration-based is also helpful for the data motion, if you need to handle lots of data, it's better to use migration-based approach, it handle the structure change and data motion by nature way.

### From team side

Migration approach requires more coordination and displines, team memebers needs to handle merge conflict carefully, and all by their hand, tools can help little.  

So in small teams, migration approach may be a better way, and state-based approach is widely used in large distributed teams.

Take in mind that it doesn't mean stick to one approach in whole project life time. It's easy to change from one approach to another. You may begin from migration-based, then change to state-based, and vice-versa. All you need to do is create a base-line, give that base-line a version number, from then on, change the approach.

## Comine together

You can combine these two approach together. Since it's easier to have state-based approach for store procedures, we create a folder 'StoreProcedures' in database project, and create .sql files for each procedures. In the migration script, we change the command to run a sql script file for those procedures.

By using this we, all the changes in procedures will be showed in source control tools, and the merge conflicts will be easier to see and handle by that tools.

It's strongly recormended not put logic in the database, if you follow DDD closely, all the logic can save in repository layer, and it will be handle by source code controll system.

## Refer

1. [The elphant in the room: Continuous Delivery for Database](http://vimeo.com/131637362). Alex Yates, NDC talk.
