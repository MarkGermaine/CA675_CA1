#import pandas library to load and transform dataset
import pandas as pd
toys = pd.read_json("/Users/markgermaine/Downloads/archive (2)/Toys_and_Games/Toys_and_Games.json",  lines= True)
sports = pd.read_json('/Users/markgermaine/Downloads/archive (2)/Sports_and_Outdoors/Sports_and_Outdoors.json', lines= True)

#check whether dataset appropriate for task
toys.head()
toys.info()
sports.head()
sports.info()

#Store the dataframe as a csv to upload to AWS
toys.to_csv("toys.csv")
sports.to_csv("sports.csv")