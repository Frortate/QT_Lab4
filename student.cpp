#include "student.h"

Student::Student()
{

}
QString Student::getPersonSt() const
{
    return personSt;
}
int Student::getNumberBibl() const
{
    return numberBibl;
}
int Student::getCountBooks() const
{
    return countBooks;
}
void Student::setPersonSt(const QString &St)
{
    personSt = St;
}
void Student::setNumberBibl(const int number)
{
    numberBibl = number;
}
void Student::setCountBooks(const int books)
{
    countBooks = books;
}

