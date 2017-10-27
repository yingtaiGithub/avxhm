import logging
import logging.handlers

log_file = ".log"
logger = logging.getLogger(__name__)
logger.setLevel(logging.DEBUG)
fileHandler = logging.FileHandler(log_file)
formatter = logging.Formatter('[%(levelname)s|%(filename)s:%(lineno)s] %(asctime)s > %(message)s')
fileHandler.setFormatter(formatter)
logger.addHandler(fileHandler)


mysql_server = 'localhost'
mysql_un = 'root'
mysql_pw = "1234"
db_name = "avx"
