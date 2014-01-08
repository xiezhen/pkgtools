import os,sys
import subprocess

if __name__=='__main__':
    cmsarch='slc6_amd64_gcc472'
    if len(sys.argv)>1:
      cmsarch=sys.argv[1]
    rpms=os.listdir(os.path.join(cmsarch,'rpm'))
    #with open('extractrpm.log','w') as mylog:
    with open('/dev/null','w') as mylog:
        for rpmname in rpms:
            print os.path.join(cmsarch,'rpm',rpmname)
            p1=subprocess.Popen(['rpm2cpio',os.path.join(cmsarch,'rpm',rpmname)], shell=False, stdout=subprocess.PIPE, stderr=mylog )
            p2=subprocess.Popen(['cpio','-ivd'], shell=False, stdin=p1.stdout, stdout=subprocess.PIPE, stderr=mylog )
            p1.stdout.close()
            output,err=p2.communicate()


            

        
      
