#include "studentlist.h"
#include <QDebug>

StudentList::StudentList(QObject* parent):QAbstractListModel(parent)
{

}

StudentList::~StudentList()
{

}

int StudentList::rowCount(const QModelIndex&) const
{
    return listOfStudents.size();
}


QVariant StudentList::data(const QModelIndex &index, int role) const
{
    if (index.row() < 0 || index.row() >= listOfStudents.size())
            return QVariant();
      {
        switch (role) {
                case name:
                    return QVariant(listOfStudents.at(index.row()).getPersonSt());
                case number:
                    return QVariant(listOfStudents.at(index.row()).getNumberBibl());

                case count:
                    return QVariant(listOfStudents.at(index.row()).getCountBooks());
                case student_id:
                    return index.row();

                default:
                    return QVariant();
            }

    }
}

QHash<int, QByteArray> StudentList::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[name] = "NameOfStudent";
    roles[number] = "DocumentNumber";
    roles[count] = "NumberOfBooks";
    roles[student_id] = "Id_student";
       return roles;
}

void StudentList::add(const QString& nameSt, const int numberSt, const int countSt){
     Student student;
    student.setPersonSt(nameSt);
    student.setNumberBibl(numberSt);
    student.setCountBooks(countSt);

    beginInsertRows(QModelIndex(),listOfStudents.size(),listOfStudents.size());
    listOfStudents.append(student);  //добавление в конец списка
    endInsertRows();

}

QAbstractListModel* StudentList::getModel(){
    return this;
}

void StudentList::del(const int index){

     if (index >= 0 && index < listOfStudents.size())
     {

    // сообщение модели о процессе удаления данных
    beginRemoveRows(QModelIndex(), index, index);
        listOfStudents.removeAt(index);
              endRemoveRows();
     }
     else qDebug() << "Error index";

}

void StudentList::edit(const QString& nameSt, const int numberSt, const int countSt, const int index) {
     if(index >= 0 && index < listOfStudents.size() )
     {
        auto& currentStudent = listOfStudents[index];
        if (currentStudent.getPersonSt().compare(nameSt)!=0 || currentStudent.getNumberBibl() != numberSt || currentStudent.getCountBooks() != countSt)
        {
            currentStudent.setPersonSt(nameSt);
            currentStudent.setNumberBibl(numberSt);
            currentStudent.setCountBooks(countSt);

            auto modelIndex = createIndex(index, 0);
            emit dataChanged(modelIndex, modelIndex);
            qDebug() << listOfStudents[index].getNumberBibl();
        }

     }
      else qDebug() << "Error index";
}
bool StudentList::isConnectionOpen(){
    return true;
}
