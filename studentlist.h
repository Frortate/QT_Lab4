#ifndef STUDENTLIST_H
#define STUDENTLIST_H


#include <QAbstractListModel>
#include <QVariant>
#include <QList>
#include <QModelIndex>
#include <QItemSelectionModel>
#include "student.h"

class StudentList : public QAbstractListModel
{
    Q_OBJECT

    Q_PROPERTY(QAbstractListModel* studentModel READ getModel CONSTANT)  /* первый параметр - тип свойства (property)
                                                                     второй параметр - имя свойства, по которому будем обращаться к реальной модели в qml-файле
                                                                     третий параметр - метод С++ для получения значения свойства (получим саму модель)
                                                                     CONSTANT - qml получит свойство однократно, и в процессе работы это свойство изменяться не будет */
    Q_PROPERTY(bool IsConnectionOpen READ isConnectionOpen CONSTANT)

private:
    QList<Student> listOfStudents; // непосредственно данные
    QAbstractListModel *getModel();
 bool isConnectionOpen();
public:
    StudentList(QObject *parent = nullptr);
    ~StudentList() override;

    // количество колонок
    int rowCount(const QModelIndex& parent = QModelIndex()) const override;

     // возвращение данных модели по указанному индексу и роли
    QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const override;

    enum ResentRoles {
            name = Qt::DisplayRole,
            number = Qt::UserRole + 1,
            count = Qt::UserRole + 2,
            student_id = Qt::UserRole + 3
       };

    QHash<int, QByteArray> roleNames() const override;

    Q_INVOKABLE void add(const QString& nameSt, const int numberSt, const int countSt);  // макрос указывает, что к методу можно обратиться из QML
    Q_INVOKABLE void del(const int index);
    Q_INVOKABLE void edit(const QString& nameSt, const int numberSt, const int countSt, const int index);
};

#endif // STUDENTLIST_H
