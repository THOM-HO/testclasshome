@isTest
public class BatchStudentTest {
    @isTest
    static void testBatch(){
        List<Diem__c> diems = new List<Diem__c>();
        diems = [SELECT Id FROM Diem__c];
        delete diems;
        Integer countStudent = [SELECT COUNT() FROM HocSinh__c];
        Test.startTest();
        BatchStudent batch = new BatchStudent();
        database.executeBatch(batch);
        Test.stopTest();
        Integer countPoint = [SELECT COUNT() FROM Diem__c ];
        System.assertEquals( countStudent*3, countPoint);
    }

    @isTest
    static void testBatch1(){
        delete  [SELECT Id FROM Diem__c LIMIT 5];
        // diems
        Integer countStudent = [SELECT COUNT() FROM HocSinh__c];
        Test.startTest();
        BatchStudent batch = new BatchStudent();
        database.executeBatch(batch);
        Test.stopTest();
        
        Integer countPoint = [SELECT COUNT() FROM Diem__c ];
        System.assertEquals( countStudent*3, countPoint);
    }

    private static List<Lop__c> listClass;
    private static List<HocSinh__c> listStudent;
    private static List<Diem__c> listPoint;
    static {
        listClass = new List<Lop__c>();
        listClass.add(createClass('Lop 1'));
        listClass.add(createClass('Lop 2'));
        listClass.add(createClass('Lop 3'));
        listClass.add(createClass('Lop 4'));
        insert listClass;

        listStudent = new List<HocSinh__c>();
        Date birthday = date.newInstance(2012,05,22);
        listStudent.add(createStudent('Trần ', 'Văn A', true, birthday, 7, 8, 9, listClass[0].Id));
        listStudent.add(createStudent('Trần ', 'Văn B', true, birthday, 7, 8, 9, listClass[1].Id));
        listStudent.add(createStudent('Trần ', 'Văn C', true, birthday, 7, 8, 9, listClass[2].Id));
        listStudent.add(createStudent('Trần ', 'Văn D', true, birthday, 7, 8, 9, listClass[3].Id));
        listStudent.add(createStudent('Trần ', 'Văn E', true, birthday, 7, 8, 9, listClass[1].Id));
        insert listStudent;

        listPoint = new List<Diem__c>();
        for(Integer i = 0 ; i < 2 ; i++){
           listPoint.add(createPoint(listStudent[i].Id, listStudent[i].Diem1__c , 'Hóa')) ;
           listPoint.add(createPoint(listStudent[i].Id, listStudent[i].Diem2__c , 'Lý')) ;
           listPoint.add(createPoint(listStudent[i].Id, listStudent[i].Diem3__c , 'Toán')) ;
        }
        insert listPoint;
    }

    private static HocSinh__c createStudent(String firstName, String lastName, Boolean sex, Date birthDay, Integer point1, Integer point2, Integer point3, Id idClass){
        HocSinh__c student =  new HocSinh__c();
        student.TenHocSinh__c = firstName;
        student.HoHocSinh__c = lastName;
        student.Lop__c = idClass;
        student.Diem1__c = point1;
        student.Diem2__c = point2;
        student.Diem3__c = point3;
        student.GioiTinh__c = sex;
        student.NgaySinh__c = birthDay;
        return student;
    }

    private static Lop__c createClass(String className) {
       Lop__c objClass = new Lop__c();
       objClass.TenLop__c = className;
       return objClass;
    }

    private static Diem__c createPoint(Id studentId, Decimal point,String subject) {
        Diem__c objPoint = new Diem__c();
        objPoint.HocSinh__c = studentId;
        objPoint.Diem__c = point;
        objPoint.Mon__c = subject;
        return objPoint;
     }

}

// @isTest
//     static void testBatch2() {
//         BatchStudent batch = new BatchStudent();     
//         Test.startTest();
//         database.executeBatch(batch);
//         Integer start = System.Now().millisecond();
//         while (System.Now().millisecond() < (start + 100)) {
//             if( System.Now().millisecond() == (start + 90)) {
//                 List<Diem__c> diems = new List<Diem__c>();
//                 diems = [SELECT Id FROM Diem__c LIMIT 5];
//                 // delete diems;
//                 System.debug('size' + diems.size());
//                 delete diems;
//             }
//         }
//         database.executeBatch(batch);

//         Test.stopTest();
//         Integer countPoint = [SELECT COUNT() FROM Diem__c ];
//         System.assertEquals(15, countPoint);
//     }