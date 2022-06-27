#!/bin/bash

#
# Released under MIT License
# Copyright (c) 2019-2022 Jose Manuel Churro Carvalho
# Permission is hereby granted, free of charge, to any person obtaining a copy of this software 
# and associated documentation files (the "Software"), to deal in the Software without restriction, 
# including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, 
# and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
# The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, 
# INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. 
# IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, 
# WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#

echo "#!/bin/bash" > /home/local/src/alfresco/src/git/git-clone-alfresco.sh
echo "" >> /home/local/src/alfresco/src/git/git-clone-alfresco.sh
curl "https://api.github.com/orgs/Alfresco/repos?page=1&per_page=1000" | grep 'html_url' | awk '{print $2}' | sed 's/"//g' | sed 's/,//g' | sort | uniq -u >> /home/local/src/alfresco/src/git/git-clone-alfresco.sh
curl "https://api.github.com/orgs/Alfresco/repos?page=2&per_page=1000" | grep 'html_url' | awk '{print $2}' | sed 's/"//g' | sed 's/,//g' | sort | uniq -u >> /home/local/src/alfresco/src/git/git-clone-alfresco.sh
curl "https://api.github.com/orgs/Alfresco/repos?page=3&per_page=1000" | grep 'html_url' | awk '{print $2}' | sed 's/"//g' | sed 's/,//g' | sort | uniq -u >> /home/local/src/alfresco/src/git/git-clone-alfresco.sh
curl "https://api.github.com/orgs/Alfresco/repos?page=4&per_page=1000" | grep 'html_url' | awk '{print $2}' | sed 's/"//g' | sed 's/,//g' | sort | uniq -u >> /home/local/src/alfresco/src/git/git-clone-alfresco.sh
sed -i 's+https://github.com/Alfresco+git clone --recursive https://github.com/Alfresco+g' /home/local/src/alfresco/src/git/git-clone-alfresco.sh
chmod a+x /home/local/src/alfresco/src/git/git-clone-alfresco.sh

echo "#!/bin/bash" > /home/local/src/alfresco/src/git/git-clone-activiti.sh
echo "" >> /home/local/src/alfresco/src/git/git-clone-activiti.sh
curl "https://api.github.com/orgs/Activiti/repos?page=1&per_page=1000" | grep 'html_url' | awk '{print $2}' | sed 's/"//g' | sed 's/,//g' | sort | uniq -u >> /home/local/src/alfresco/src/git/git-clone-activiti.sh
curl "https://api.github.com/orgs/Activiti/repos?page=2&per_page=1000" | grep 'html_url' | awk '{print $2}' | sed 's/"//g' | sed 's/,//g' | sort | uniq -u >> /home/local/src/alfresco/src/git/git-clone-activiti.sh
curl "https://api.github.com/orgs/Activiti/repos?page=3&per_page=1000" | grep 'html_url' | awk '{print $2}' | sed 's/"//g' | sed 's/,//g' | sort | uniq -u >> /home/local/src/alfresco/src/git/git-clone-activiti.sh
sed -i 's+https://github.com/Activiti+git clone --recursive https://github.com/Activiti+g' /home/local/src/alfresco/src/git/git-clone-activiti.sh
chmod a+x /home/local/src/alfresco/src/git/git-clone-activiti.sh

echo "#!/bin/bash" > /home/local/src/alfresco/src/git/git-clone-orderofthebee.sh
echo "" >> /home/local/src/alfresco/src/git/git-clone-orderofthebee.sh
curl "https://api.github.com/orgs/OrderOfTheBee/repos?page=1&per_page=1000" | grep 'html_url' | awk '{print $2}' | sed 's/"//g' | sed 's/,//g' | sort | uniq -u >> /home/local/src/alfresco/src/git/git-clone-orderofthebee.sh
curl "https://api.github.com/orgs/OrderOfTheBee/repos?page=2&per_page=1000" | grep 'html_url' | awk '{print $2}' | sed 's/"//g' | sed 's/,//g' | sort | uniq -u >> /home/local/src/alfresco/src/git/git-clone-orderofthebee.sh
sed -i 's+https://github.com/OrderOfTheBee+git clone --recursive https://github.com/OrderOfTheBee+g' /home/local/src/alfresco/src/git/git-clone-orderofthebee.sh
chmod a+x /home/local/src/alfresco/src/git/git-clone-orderofthebee.sh

