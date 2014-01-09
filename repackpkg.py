import os,sys,re,urllib,tarfile,subprocess
import multiprocessing as mp

logfile='/dev/null'
preserveddir=['bin','lib','include','python']

def extractrpm( (cmsarch,rpmname) ):
    with open(logfile,'w') as mylog:
        p1=subprocess.Popen(['rpm2cpio',os.path.join(cmsarch,'rpm',rpmname)], shell=False, stdout=subprocess.PIPE, stderr=mylog )
        p2=subprocess.Popen(['cpio','-ivd'], shell=False, stdin=p1.stdout, stdout=subprocess.PIPE, stderr=mylog )
        p1.stdout.close()
        output,err=p2.communicate()

def parsepkgname(pkgname):
    '''
    parse pkgname into directory list
    example: 
    pkgname=lcg+root+5.34.09-1-1
    $prefix/lcg/root/5.34.09/
    '''
    result=[]
    result=pkgname.split('+')
    if result and result[-1].find('-')!=-1:
        namepieces=result.pop().split('-')
        pos=[i for i,x in enumerate(namepieces) if x.isdigit()][0]
        newname='-'.join(namepieces[0:pos])
        result.append(newname)
    return result

def repack( (source_dir,save_as) ):
    '''
    sourceurl: protocol://path  , example: file:///home/zhen/opt/cmssw/slc6_amd64_gcc472/external
 
    '''
    with tarfile.open(save_as+'.tar.gz','w:gz') as tar:
        for saveddir in preserveddir:
            if not os.path.exists( os.path.join(source_dir,saveddir) ): continue
            tar.add(os.path.join(source_dir,saveddir), arcname=os.path.join(save_as,saveddir),recursive=True) 
            
if __name__=='__main__':

    cmsarch='slc6_amd64_gcc472'
    cmsprefix=['opt','cmssw']

    if len(sys.argv)>1:
        cmsarch=sys.argv[1]
    cmsprefix.append(cmsarch)
    rpms=os.listdir(os.path.join(cmsarch,'rpm'))

    # extract rpm into directory structure
    extractparams=[]
    repackparams=[]
    for rpmname in rpms:
        dirtree=parsepkgname(rpmname)
        fulldirtree=cmsprefix+dirtree
        sourcedir=os.path.join(*fulldirtree)
        save_as='-'.join(dirtree[-2:])
        if not os.path.exists(sourcedir):
            extractparams.append( (cmsarch,rpmname) )
        if not os.path.exists(save_as+'.tar.gz'):
            repackparams.append( (sourcedir,save_as) )
    print extractparams
    print repackparams
    pool = mp.Pool(processes=4)
    print 'extract rpm content'
    pool.map(extractrpm,extractparams)
    #pack selected contents into tar.gz
    print 'pack selected contents into tar.gz'
    pool.map(repack,repackparams)

    
        
    
    
