extension Double {
    
    /// Double 타입의 값을 다른 범위로 변환합니다.
    /// - Parameters:
    ///   - from: 변환할 값
    ///   - fromMin: 입력값의 최소값
    ///   - fromMax: 입력값의 최대값
    ///   - toMin: 출력값의 최소값
    ///   - toMax: 출력값의 최대값
    /// - Returns: 변환된 값
    static func remap(
        from: Double,
        fromMin: Double,
        fromMax: Double,
        toMin: Double,
        toMax: Double
    ) -> Double {
        let fromAbs: Double  =  from - fromMin
        let fromMaxAbs: Double = fromMax - fromMin
        let normal: Double = fromAbs / fromMaxAbs
        let toMaxAbs = toMax - toMin
        let toAbs: Double = toMaxAbs * normal
        var to: Double = toAbs + toMin
        
        to = abs(to)
        
        // 출력 범위에서의 값이 최소값과 최대값을 벗어나지 않도록 clamp(한정) 처리
        if to < toMin { return toMin }
        if to > toMax { return toMax }
       
        return to
    }
    
    // ex) fromMin이 0, fromMax가 100, toMin이 0, toMax가 1이면, 50이라는 입력값은 0.5로 정규화되고, 이를 다시 출력 범위에 적용하면 0.5 * (1-0) + 0 = 0.5가 됩니다.
}
