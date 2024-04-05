#!/usr/bin/env python
# coding: utf-8

# In[ ]:


import filedate
from pathlib import Path


# In[ ]:


for i in range(1,31):
    file_name = f'c:\\temp\\path\\cat_03_{i}.hzp'
    path = Path(file_name)
    print(path)
    path.write_text(str(""))
    a_file = filedate.File(file_name)
    createdDt = f"2022.03.{i} 13:00:00"
    print(createdDt)
    a_file.set(
        created = createdDt
    )


# In[ ]:




