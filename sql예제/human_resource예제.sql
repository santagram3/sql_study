


SELECT
    upper(first_name)
FROM employees;
SELECT
    lower(first_name)
FROM employees;
SELECT
    INITCAP (first_name)
FROM employees;

SELECT
    upper(first_name), length(first_name)
FROM employees;

SELECT
    first_name, last_name
FROM employees
WHERE lower(first_name) = 'david'

;

-- Q. employees ���̺��� job_id�� it_prog�� ����� first_name�� salary�� ����ϼ���.
--  ����1 ) ���ϱ� ���� ���� �ҹ��ڷ� �Է��� ��!
--  ����2 ) �̸��� �� 3���ڱ����� ����ϰ� �������� *�� ��ŷ�� ��. 
--          �� ���� ��Ī�� name�Դϴ�.
--  ����3 ) �޿��� ��ü 10�ڸ��� ����ϵ� �������ڸ��� *�� ����մϴ�. 
--           �� ���� ��Ī�� salary�Դϴ�.

SELECT
 RPAD(SUBSTR(first_name, 1, 3),length(first_name),'*') AS"name"
  ,LPAD(salary,10,'*') as"salary"
FROM employees
WHERE 1=1
and lower(job_id) = 'it_prog'
;










