#ifndef STUDENT_H
#define STUDENT_H

#include <QString>
class Student
{
private:

    QString personSt;
    int numberBibl;
    int countBooks;

public:
    Student();
    QString getPersonSt() const;
    int getNumberBibl() const;
    int getCountBooks() const;
    void setPersonSt(const QString &St);
    void setNumberBibl(const int number);
    void setCountBooks(const int books);
};

#endif // STUDENT_H
