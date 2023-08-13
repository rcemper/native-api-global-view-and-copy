A utility using IRIS NativeAPI to View, Copy, and Merge Globals    
This code runs rather slowly and creates a lot of network traffic.   
*Background:*      
As $QUERY is not supported by Native API  it is a rather long and     
boring workaround with the functions **IsDefined** (aka $DATA) and       
**GetNext** (aka $ORDER) to examine all Global nodes with value   
and passing the *structural* nodes.

You have to provide   
- your credentials for server access    
- your level of error handling
-  
First, you make a connection to the target SuperServer Port
    
````   
do ##class(nacl.Client).Connect("192.168.0.99",41773)   
````    
- VIEW and COPY are the same code   
- VIEW is simply a COPY to NUL device
- The target in COPY can have a different name
- Using a local variable as target mimics the MERGE command
- Start and Stop Subscript allow partial operation
- Stop Subscript is the first to be excluded.

````   
Do ##class(nacl.GVC).Connect(serverIP,serverPORT,namespace,username,password)    

Do ##class(nacl.GVC).View(globalname,startsubscript,stopstcsript)    

Do ##class(nacl.GVC).Copy(globalname,startsubscript,stopstcsript,targetname)    
````
Copy writes a View of the crated output.    

### Prerequisites
Make sure you have [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) and [Docker desktop](https://www.docker.com/products/docker-desktop) installed.    

On your target server, you need to install    
https://github.com/rcemper/native-api-command-line-extension    

### Installation   
Clone/git pull the repo into any local directory  

````    
git https://github.com/rcemper/native-api-command-line-client    
````    
   
Run the IRIS container with your project:   

````
docker-compose up -d --build    
````
## How to Test it    
````
docker-compose exec iris iris session iris

![image](https://github.com/rcemper/native-api-global-view-and-copy/assets/31236645/c9ba7cce-8d13-4321-b967-172985ea9d63)

   
Copy writes a View of the crated output.     
  

[Article in DC](https://community.intersystems.com/post/remote-global-listing-using-nativeapi-objectscript-1)
  
        
