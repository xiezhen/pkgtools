import os,sys,urllib,logging
import multiprocessing as mp

def download((downloadurl,save_as)):
    print 'Download %s as %s '%(downloadurl,save_as)
    try: 
        urllib.urlretrieve(downloadurl, filename=save_as)
    except Exception, e:
        logging.warn('error download_url %s: %s'%(downloadurl,e))

if __name__=='__main__':
    cmsbaseurl='http://cmsrep.cern.ch/cmssw/cms/RPMS'
    cmsarch='slc6_amd64_gcc472'
    if len(sys.argv)>1:
      cmsarch=sys.argv[1]
    cmsurl=cmsbaseurl+'/'+cmsarch
    filelist=['lcg+root+5.34.09-1-1',
              'external+expat+2.0.1-cms-1-1',
              'external+frontier_client+2.8.8-cms-1-1',
              'cms+coral+CORAL_2_3_21-cms32-1-1',
              'external+oracle+11.2.0.3.0__10.2.0.4.0-cms-1-1',
              'external+boost+1.47.0-1-1',
              'external+xerces-c+2.8.0-cms-1-1',
              'external+gcc+4.7.2-cms-1-1',
              'external+xz+5.0.3-cms-1-1'
              ]
    rpms=os.path.join(cmsarch,'.rpm')
    links=[]
    for basename in filelist:
        filename='.'.join([basename,cmsarch,'rpm'])
        url=cmsurl+'/'+filename
        links.append((url,filename))
    pool = mp.Pool(processes=5)
    pool.map(download,(links))

