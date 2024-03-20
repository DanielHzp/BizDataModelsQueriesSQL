

--TSM process entity
select * from mTrainingRequest

--TSM Training type parameter entity
select * from mTrainingType
select * from pTrainingType

--Business entity of TSM
select * from mTrainingSessionMng

--Collection entity where training session students are loaded
select * from mAttendee

select * from mSessionModules where sCaseNumber='TSM372'

--Collection entity where moddle web service writes student prerequisites progress   xMoodlePrerequisites
select * from mMoodlePrerequisites where scaseNumber like '%TSM180%' and bIsInstructorLed='true' --and bInstructorLedAttended='true' 

--Collection of training prerequisites of each course or workshop
select * from pTSMPrerequisites

--TSM training language parameter entity
select * from TCM_Language

--TSM case status parameter entity
select * from pTSMCaseStatus


--Student CRM Training History
select * from mTSMStudentHistory

select * from mInstructorledHist where bCreatedinMyBizagi=1 sCorporateEmail like '%juankberni@gmail.com%'

select * from mCertificatesHistory


--Master entity for attendees companies
select * from mCompaniesAttendees


select * from pTSMAdditionalCC
select * from mAdditionalCCRecip



select * from wfcase

select * from pworkshoptype




--Xpress replicated entitites
select * from pXpressAttendeesREP where creatorName not like '%elearning%'

select * from TrainingCourseInstan WHERE sXpressBusinessKey=801

select * from TrainingCourse

 


--Proess entity data sync process
select * from mTSMXpressDataSync

select * from mNewStudentHistory;












--Prerequisites TSM solo My Bizagi TSM 
select	mInstructorledHist.sOriginCaseNumber,mTrainingRequest.sCaseNumber,mTSMStudentHistory.sFirstName,mTSMStudentHistory.sLastName,
		mInstructorledHist.bCreatedinMyBizagi,mMoodlePrerequisites.sPrerequisiteName,mMoodlePrerequisites.iMoodleProgress,*

from mInstructorledHist left join mTSMStudentHistory
on mTSMStudentHistory.idmTSMStudentHistory=mInstructorledHist.mTSMStudentHistory
left join mTrainingRequest on mTrainingRequest.sCaseNumber=mInstructorledHist.sOriginCaseNumber
left join mTrainingSessionMng on mTrainingSessionMng.idmTrainingSessionMng=mTrainingRequest.kmTrainingSessionMng
--left join mTrainingDetails on mTrainingDetails.idmTrainingDetails=mTrainingSessionMng.mTrainingDetails
left join mAttendee on mAttendee.mTrainingSessionMng=mTrainingSessionMng.idmTrainingSessionMng
left join mMoodlePrerequisites on mMoodlePrerequisites.mAttendee=mAttendee.idmAttendee

where mInstructorledHist.bCreatedinMyBizagi =1






--Prerequisitos My Bizagi y Xpress usando correo como llave
--Query 1 prerequisitos

select	mInstructorledHist.sOriginCaseNumber,mInstructorledHist.dTrainingStartDate,mInstructorledHist.dTrainingEndDate,
		mTSMStudentHistory.sCorporateEmail,mAttendee.sFullName,mInstructorledHist.bCreatedinMyBizagi,
		mMoodlePrerequisites.bIsInstructorLed,mMoodlePrerequisites.sPrerequisiteName,mAttendee.bInstructorledPrereqMet,mAttendee.bAllPrerequisitesMet as AllElearningPrereqMet,*

from mInstructorledHist left join mTSMStudentHistory
on mTSMStudentHistory.idmTSMStudentHistory=mInstructorledHist.mTSMStudentHistory
left join mAttendee on mAttendee.sCorparateEmail=mTSMStudentHistory.sCorporateEmail
left join mMoodlePrerequisites on mMoodlePrerequisites.mAttendee=mAttendee.idmAttendee

where mMoodlePrerequisites.sPrerequisiteName is not null and mMoodlePrerequisites.bIsInstructorLed=1
order by mInstructorledHist.sOriginCaseNumber ASC




--Query 2 workshops
select	mInstructorledHist.sOriginCaseNumber,mInstructorledHist.dTrainingStartDate,mInstructorledHist.dTrainingEndDate,
		mTSMStudentHistory.sCorporateEmail,mAttendee.sFullName,mInstructorledHist.bCreatedinMyBizagi,
		mAttendee.bInstructorledPrereqMet,mAttendee.bAllPrerequisitesMet as AllElearningPrereqMet,mTrainingSessionMng.kpTrainingType,mTrainingType.sName,*

from mInstructorledHist left join mTSMStudentHistory
on mTSMStudentHistory.idmTSMStudentHistory=mInstructorledHist.mTSMStudentHistory
left join mAttendee on mAttendee.sCorparateEmail=mTSMStudentHistory.sCorporateEmail
left join mTrainingSessionMng on mTrainingSessionMng.idmTrainingSessionMng=mAttendee.mTrainingSessionMng
left join mTrainingType on mTrainingType.idmTrainingType=mTrainingSessionMng.kpTrainingType

where mTrainingType.sCode='01'
order by mInstructorledHist.sOriginCaseNumber ASC







--Query 3 Prerequisitos cursos y equivalentes
select	mInstructorledHist.sOriginCaseNumber,mInstructorledHist.dTrainingStartDate,mInstructorledHist.dTrainingEndDate,
		mTSMStudentHistory.sCorporateEmail,mMoodlePrerequisites.sAttendeeEmail,mAttendee.sFullName,mInstructorledHist.bCreatedinMyBizagi,
		mMoodlePrerequisites.bIsInstructorLed,mMoodlePrerequisites.sPrerequisiteName,mMoodlePrerequisites.sInstructorLedPrereqId,mAttendee.bInstructorledPrereqMet,mAttendee.bAllPrerequisitesMet as AllElearningPrereqMet,mTrainingType.sName,*

from mInstructorledHist left join mTSMStudentHistory
on mTSMStudentHistory.idmTSMStudentHistory=mInstructorledHist.mTSMStudentHistory
left join mAttendee on mAttendee.sCorparateEmail=mTSMStudentHistory.sCorporateEmail
left join mMoodlePrerequisites on mMoodlePrerequisites.mAttendee=mAttendee.idmAttendee
left join mTrainingSessionMng on mTrainingSessionMng.idmTrainingSessionMng=mAttendee.mTrainingSessionMng
left join mTrainingType on mTrainingType.idmTrainingType=mTrainingSessionMng.kpTrainingType

where mMoodlePrerequisites.sPrerequisiteName is not null and mMoodlePrerequisites.bIsInstructorLed=1 and mTrainingType.sCode='02'
order by mInstructorledHist.sOriginCaseNumber ASC, mMoodlePrerequisites.sInstructorLedPrereqId DESC





















--Historico estudiantes entrenamientos instructor led tomados 
select	mInstructorledHist.sOriginCaseNumber,mInstructorledHist.dTrainingStartDate,mInstructorledHist.dTrainingEndDate,
		mTSMStudentHistory.sCorporateEmail,mTSMStudentHistory.sFirstName,mTSMStudentHistory.sLastName,
		mInstructorledHist.bCreatedinMyBizagi,mInstructorledHist.sTrainingName as InstructorLedTraining,*

from	mInstructorledHist left join mTSMStudentHistory
		on mTSMStudentHistory.idmTSMStudentHistory=mInstructorledHist.mTSMStudentHistory
order by mInstructorledHist.dTrainingStartDate DESC


























