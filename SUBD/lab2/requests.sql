--���������� ���������� ������ ������������ ��������� �������:
--  ����� �������� ��� ���� ��������, ����������� �� ����������� ����������� � ������� ���� (����������� �������� � �������� �������);
--	����� �������� ��� ���� �������� � ��������� ��������� � ������������� ������;
--	����� �������� � ���� ������� ��������, �� ������� ���� ��������� ����� ������� ��������� ������� � ������� ����. ������������� ��������� ������� �� �������� ���� ����.

--  ����� �������� ��� ���� ��������, ����������� �� ����������� ����������� � ������� ���� (����������� �������� � �������� �������);
SELECT oper.id, oper."date", oper.description, oper.cash, oper.amount, fam_m.name, fam_m.surname, oper_t.name AS ��������������, main_oper_t.name AS �����������, top_oper_t.name AS ����������� 
FROM operations oper
    JOIN family_members fam_m ON oper.family_members_id = fam_m.id
    JOIN operation_types oper_t ON oper.operation_types_id = oper_t.id
    JOIN main_operation_types main_oper_t ON oper_t.main_operation_types_id = main_oper_t.id 
    JOIN top_operation_types top_oper_t ON main_oper_t.top_operation_types_id = top_oper_t.id
    WHERE top_oper_t.name = '������'
    AND main_oper_t.name = '�������'
    AND oper."date" BETWEEN trunc(sysdate, 'YEAR') AND add_months(trunc(sysdate, 'YEAR'), 12)-1/24/60/60;
    
--	����� �������� ��� ���� �������� � ��������� ��������� � ������������� ������;
SELECT oper.id, oper."date", oper.description, oper.cash, oper.amount, fam_m.name, fam_m.surname, oper_t.name AS ��������������, main_oper_t.name AS �����������, top_oper_t.name AS ����������� 
FROM operations oper
    JOIN family_members fam_m ON oper.family_members_id = fam_m.id
    JOIN operation_types oper_t ON oper.operation_types_id = oper_t.id
    JOIN main_operation_types main_oper_t ON oper_t.main_operation_types_id = main_oper_t.id 
    JOIN top_operation_types top_oper_t ON main_oper_t.top_operation_types_id = top_oper_t.id
    WHERE oper.amount < 0;
    
-- ������� �) � ��� ���� ����� ����� �� ���� ��������
SELECT oper_t.name, top_oper_t.name AS �����������, SUM(oper.amount) AS ����������
FROM operations oper
    JOIN family_members fam_m ON oper.family_members_id = fam_m.id
    JOIN operation_types oper_t ON oper.operation_types_id = oper_t.id
    JOIN main_operation_types main_oper_t ON oper_t.main_operation_types_id = main_oper_t.id 
    JOIN top_operation_types top_oper_t ON main_oper_t.top_operation_types_id = top_oper_t.id
    GROUP BY oper_t.name, top_oper_t.name HAVING SUM(oper.amount) < 0;
    
--	����� �������� � ���� ������� ��������, �� ������� ���� ��������� ����� ������� ��������� ������� � ������� ����. ������������� ��������� ������� �� �������� ���� ����.
SELECT * FROM(SELECT main_oper_t.name, SUM(oper.amount) AS ����������
FROM operations oper
    JOIN family_members fam_m ON oper.family_members_id = fam_m.id
    JOIN operation_types oper_t ON oper.operation_types_id = oper_t.id
    JOIN main_operation_types main_oper_t ON oper_t.main_operation_types_id = main_oper_t.id 
    JOIN top_operation_types top_oper_t ON main_oper_t.top_operation_types_id = top_oper_t.id
    WHERE top_oper_t.name = '������'
    AND oper."date" BETWEEN trunc(sysdate, 'YEAR') AND add_months(trunc(sysdate, 'YEAR'), 12)-1/24/60/60
    GROUP BY main_oper_t.name ORDER BY ���������� DESC)
    WHERE ROWNUM <=5;
