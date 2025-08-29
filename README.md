## 디렉터리 구조

```
01_database/
 ├── *.sql        # SQL 실습 파일 (day02.sql ~ day20.sql 등)
 ├── *.txt        # 각 실습/과제 설명 정리
 ├── *.csv        # 데이터셋 (Netflix, Disney+, Amazon Prime)
```

## 데이터셋

- **netflix_titles.csv**: 넷플릭스 콘텐츠 메타데이터
- **disney_plus_titles.csv**: 디즈니플러스 콘텐츠 메타데이터
- **amazon_prime_titles.csv**: 아마존 프라임 콘텐츠 메타데이터

이 데이터셋들은 영화/시리즈의 제목, 장르, 개봉 연도, 국가 등의 속성을 담고 있습니다. SQL 실습에서 데이터 분석에 사용됩니다.

## 실습 목차

| Day | SQL 파일 | 설명 파일 |
|---|---|---|
| Day 02 | `01_database/day02.sql` | `01_database/day02.txt` |
| Day 03 | `01_database/day03.sql` | `01_database/day03.txt` |
| Day 04 | `01_database/day04.sql` | `01_database/day04.txt` |
| Day 05 | `01_database/day05.sql` | `01_database/day05.txt` |
| Day 06 | `01_database/day06.sql` | `01_database/day06.txt` |
| Day 07 | `01_database/day07.sql` | `01_database/day07.txt` |
| Day 08 | `01_database/day08.sql` | `01_database/day08.txt` |
| Day 08 | `01_database/day08_hptl_mast_ddl.sql` | `01_database/day08.txt` |
| Day 09 | `01_database/day09.sql` | `01_database/day09.txt` |
| Day 10 | `01_database/day10.sql` | `01_database/day10.txt` |
| Day 12 | `01_database/day12.sql` | `01_database/day12.txt` |
| Day 13 | `01_database/day13.sql` | `01_database/day13.txt` |
| Day 14 | `01_database/day14.sql` | - |
| Day 15 | `01_database/day15.sql` | `01_database/day15.txt` |
| Day 16 | `01_database/day16.sql` | - |
| Day 17 | `01_database/day17.sql` | `01_database/day17.txt` |
| Day 20 | `01_database/day20.sql` | - |


## 실습 방법

1. MySQL 또는 MariaDB 같은 RDBMS 설치  
   (예: Docker, XAMPP, 로컬 설치 등)

2. 데이터베이스 생성:
   ```sql
   CREATE DATABASE streaming;
   USE streaming;
   ```

3. 각 실습 파일 실행:
   ```bash
   mysql -u <user> -p streaming < 01_database/day02.sql
   ```

4. 텍스트(`.txt`) 파일을 참고하여 쿼리 수행 및 결과 확인.

5. 필요 시 CSV 데이터셋을 `LOAD DATA` 또는 `pandas`를 활용해 DB에 적재:
   ```sql
   LOAD DATA INFILE 'netflix_titles.csv'
   INTO TABLE netflix_titles
   FIELDS TERMINATED BY ','
   ENCLOSED BY '"'
   LINES TERMINATED BY '\n'
   IGNORE 1 ROWS;
   ```

## 학습 범위

- 기본 SQL 구문 (SELECT, INSERT, UPDATE, DELETE)
- 테이블 생성 및 DDL
- GROUP BY, HAVING, ORDER BY
- JOIN (INNER/OUTER)
- 서브쿼리, 집계 함수
- 데이터셋 분석 실습

## 활용 예시

- 넷플릭스/디즈니/아마존 프라임 콘텐츠를 비교 분석하는 쿼리 작성
- 특정 장르/국가별 통계 집계
- 연도별 콘텐츠 증가 추이 분석

## 라이선스

데이터셋은 공개된 Kaggle 자료 기반일 수 있으며, 학습/연구용으로만 사용하세요.  
코드 및 스크립트는 자유롭게 수정/확장 가능합니다.
