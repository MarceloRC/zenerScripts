import os
from decouple import config
import pymongo
import logging
from objdict import ObjDict
from datetime import datetime

logging.basicConfig(level=logging.INFO)
mongoClient = pymongo.MongoClient(config('MONGO_URL'))
path = config('BASE_DIR')
db = mongoClient.logs


def ProcessDir(customerName):
    logging.info(f'{path}/{customerName}')
    if customerName is None:
        exit
    else:
        logDirs = []
        collection = db[customerName]
        collection.drop()

    customerDirs = os.listdir(f'{path}/{customerName}')
    for customerDir in customerDirs:
        completePath=f'{path}/{customerName}/{customerDir}'
        if os.path.isdir(completePath):
            logDir = ObjDict()
            logDir.Path = completePath
            logDir.Date = customerDir
            logDirs.append(logDir)
    for logDir in logDirs:
        logFiles = os.listdir(f'{logDir.Path}')
        for logFile in logFiles:
            ext = os.path.splitext(logFile)
            if (ext[1] == '.log'):
                lines = open(f'{logDir.Path}/{logFile}', "r")
                logging.info(f'openning file {logFile}')
                for i, line in enumerate (lines):
                    lineNumber=str(i+1)
                    logging.info(lineNumber)
                    try:
                        # 2023/01/29 12:25:23 INFO  : FILIPE/DEPARTAMENTO COMERCIAL/OUTROS/SARA REBELLO/Imagens/IMG_1315.JPG: Copied (new)
                        entries = line.split()
                        # Cutting out the line again to use the ':' as separator because space will not give us the file name correctly
                        entriesForFilename = line.split(':')
                    except:
                        logging.WARNING(f'Cannot split line {lineNumber} of {logFile}')
                    logLine = ObjDict()
                    if len(entries) > 2:
                        logLine.Rotina = ext[0]
                        try:
                            logLine.Data = datetime.strptime(f'{entries[0]}T{entries[1]}Z0300' , '%Y/%m/%dT%H:%M:%SZ0300')
                        except:
                            logLine.Data = datetime.strptime(f'1969/12/31 21:00:00Z0300', '%Y/%m/%d %H:%M:%SZ0300')
                        logLine.Status = entries[2]
                    if len(entriesForFilename) > 4:
                        logLine.Arquivo = entriesForFilename[3].strip()
                        logLine.Retorno = entriesForFilename[4].strip()
                        logging.info(line)
                    else:
                        logLine.Rotina = ext[0]
                        logLine.Status = line
                    collection.insert_one(logLine)

                    logging.info('Just appending the array')


dir_list = os.listdir(path)
for customerName in dir_list:
    if os.path.isdir(f'{path}/{customerName}/'):
        logging.info(customerName)
        ProcessDir(customerName)
