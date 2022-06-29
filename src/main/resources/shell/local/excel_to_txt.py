import pandas as pd

df = pd.read_excel('test_info.xlsx', header=None)		# 使用pandas模块读取数据
print('开始写入txt文件...')
df.to_csv('test_info.txt', header=None, sep='\t', index=False)		# 写入，逗号分隔
print('文件写入成功!')


