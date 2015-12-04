CREATE TABLE deployment_tracker ( 
  id INT NOT NULL AUTO_INCREMENT , 
  dbname VARCHAR(128) , 
  deployment_type VARCHAR(128) NOT NULL , 
  deployment_name VARCHAR(1024) NULL ,
  deployment_outcome VARCHAR(32) NULL ,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL ,
  is_active BOOLEAN DEFAULT TRUE ,
  deployed_by VARCHAR(32) , 
  deployed_as VARCHAR(32) , 
  reference_url TEXT , 
  PRIMARY KEY (id) ,
  INDEX index_deployment_on_deployment_name(deployment_name)
) ENGINE = INNODB;
