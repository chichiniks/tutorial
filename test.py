import json
import pandas as pd

data_file = open("yelp_academic_dataset_business.json", encoding="UTF-8")
data = []
places = []
count = 0
for line in data_file:
    data.append(json.loads(line))

checkin_df = pd.DataFrame(data)
for d in data:
    if d['city'] == 'Tampa' and d['review_count'] < 10 and d['stars'] >=4:
        places.append({'business_id': d['business_id'], 'name': d['name'],
                       'address': d['address'], 'city': d['city'], 'review_count':
                           d['review_count'], 'categories': d['categories']}),


        # , d['name'], d['address'], d['city'], d['review_count']}

print(places)
print(len(places))

with open('tampa.json', 'w') as f:
    f.write(json.dumps(places))