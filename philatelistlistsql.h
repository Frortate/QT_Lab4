#ifndef PHILATELISTLISTSQL_H
#define PHILATELISTLISTSQL_H

#include <QtSql>

class philatelistListSQL: public QSqlQueryModel
{
    Q_OBJECT

    Q_PROPERTY(QSqlQueryModel* philatelistModel READ getModel CONSTANT)
    Q_PROPERTY(bool IsConnectionOpen READ isConnectionOpen CONSTANT)

public:
    explicit philatelistListSQL(QObject *parent);
    void refresh();
    QHash<int, QByteArray> roleNames() const override;
    QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const override;

    Q_INVOKABLE void add(const QString& namePh, const QString& countryPh, const int yearPh, const int circulationPh);  // макрос указывает, что к методу можно обратиться из QML
    Q_INVOKABLE void del(const int index);
    Q_INVOKABLE void edit(const QString& namePh, const QString& countryPh, const int yearPh, const int circulationPh, const int index);
    Q_INVOKABLE QString count(const QString& textCount);


signals:

public slots:

private:
    const static char* SQL_SELECT;
    QSqlDatabase db;
    QSqlQueryModel *getModel();
    bool _isConnectionOpen;
    bool isConnectionOpen();
};

#endif // PHILATELISTLISTSQL_H
