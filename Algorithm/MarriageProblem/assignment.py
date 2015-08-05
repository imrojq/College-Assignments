import csv

class student :
    def __init__(self,id,name,entryNum):
        self.id=id
        self.name=name
        self.entryNum=entryNum
        self.prefList=[]
        self.proposedId=0
        self.receivedId=100
        
    def nextPropose(self):
        self.proposedId+=1
    
    def setReceived(self,id):
        self.receivedId=id
        
    def setPrefList(self,givenList,total):
        for i in range(total):
            if not (i in givenList or i==self.id):
                givenList.append(i)
        self.prefList=givenList
  
def changeToUpper(a):
    for i in range(len(a)):
        if not (i ==2 or a[i]==''):
            a[i]=a[i].split()[0]   #It is used to remove extraspaces at the end or beginning of entry numbers
        a[i]=a[i].upper()
    return a
 
def csvToList():
    reader=csv.reader(open('data.csv', 'rb'), delimiter=',')
    studentList=[]
    for row in reader:
        studentList.append(row)
    studentList=studentList[4:]
    studentList.sort(key=lambda x: x[1])
    return studentList

def positionMap(studentList):
    positions={}
    totalStudents=len(studentList)
    for i in range(totalStudents):
        studentList[i]=changeToUpper(studentList[i])
        positions[studentList[i][1]]=i
    return positions
 
    
def createObjectArray(studentList,positions):
    totalStudents=len(studentList)
    for i in range(totalStudents):
        row=studentList[i]
        entry=student(i,row[2],row[1])
        temp=[]
        for j in row[3:]:
            if j=='':
                break
            temp.append(positions[j])
        entry.setPrefList(temp,totalStudents)
        studentList[i]=entry
    
    
def main():
    '''This function reads the csv file and chages it to a 2D array with entries sorted in alphabetical order'''
    studentList=csvToList()  
    '''This function return the map of positions of different Entry nums in the array and changes all entrynum to uppercase'''
    positions=positionMap(studentList) 
    '''This function creates an array of student objects with each student object having components id,name,entry number,the id to which it proposed 
       id from which it recieved proposal and its own preference List'''
    createObjectArray(studentList,positions) 
    
    totalstudents=len(studentList)
        
    # Phase 1 where each person proposes to his first choice and if they accept each other, they are finalised as roomates
    for student in studentList:
        #i.setPropose(i.prefList[0])
        aim_id=student.prefList[student.proposedId]
        if studentList[aim_id].prefList[0]==student.id:
            studentList[aim_id].setReceived(student.id)
    
    # Phase 2 where each persons proposes to the persons in their preference list until they have received
    # a proposal from a person who is at a higher preference from the person to whom they have currently proposed.
    flag=True
    while flag:     # This process continues till all people have a prefered partner.
        flag=False
        for student in studentList:
            temp=100
            if student.receivedId!=100:
                temp=student.prefList.index(student.receivedId)
            if temp>student.proposedId:             # if they have received a proposal from a person at a lower preference from their current preference, then they continue to look for better choices
                if student.proposedId<len(studentList)-1:
                    student.nextPropose()       # if current proposal they propose to the next person in their preference list
                flag=True
                aim_id=student.prefList[student.proposedId]
                temp1=100
                aim_receivedId=studentList[aim_id].receivedId
                if aim_receivedId!=100:
                    temp1=studentList[aim_id].prefList.index(aim_receivedId)
                temp2=studentList[aim_id].prefList.index(student.id)
                if temp2<temp1:         # If the person receives  a proposal from a person who is above in their preference list than the proposal they currently hold they accept the offer.  
                    if aim_receivedId!=100:
                        studentList[aim_receivedId].setReceived(100)    # They take back their previous proposals to other persons.
                    if student.receivedId!=100:
                        studentList[student.receivedId].setReceived(100)
                    studentList[aim_id].setReceived(student.id)
                    student.setReceived(aim_id)
                    
    
    Partners={}
    for student in studentList:
        if student.id<student.receivedId:
            Partners[student.id]=student.receivedId
    print "The optimal groupmate pairing is :"
    for i in Partners.keys():
        print studentList[i].name,"with", studentList[Partners[i]].name
    
 
if __name__ =='__main__':
    main()
    
    
